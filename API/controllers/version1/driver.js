// MODELS
const Role = require("../../models/role");
const Phone = require("../../models/phone");
const Driver = require("../../models/driver");
const Address = require("../../models/address");
const Vehicle = require("../../models/vehicle");
const Location = require("../../models/location");

// VALIDATIONS
const { driverValidation } = require("../../validations/driver");

// UTILITIES
const DateUtil = require("../../utilities/date_utility");
const { login } = require("../../utilities/login_utility");
const Response = require("../../utilities/response_utility");
const unique = require("../../utilities/codegenerator_utility");
const ResponseMessage = require("../../utilities/messages_utility");
const PaginationUtiliy = require("../../utilities/pagination_utility");
const { resetPassword } = require("../../utilities/resetpassword_utility");
const { changePassword } = require("../../utilities/changepassword_utility");
const { createActivityLog } = require("../../utilities/activitylog_utility");

const moduleName = `Driver`;

module.exports = {
  create: async (req, res) => {
    try {
      const body = req.body;
      const { error } = driverValidation(body);

      if (error) {
        return Response.sendValidationErrorMessage(res, 400, error);
      }

      const existingDriver = await Driver.findOne({
        email: body.username,
        name: body.name,
      });

      if (existingDriver) {
        return Response.customResponse(res, 409, ResponseMessage.DATA_EXISTS);
      }

      const role = await Role.findById(body.roleId);
      const vehicle = await Vehicle.findById(body.vehicleId);
      const location = await Location.findById(body.locationId);

      if (!role) {
        return Response.customResponse(
          res,
          404,
          ResponseMessage.NO_ROLE_RECORD
        );
      }

      if (!vehicle) {
        return Response.customResponse(
          res,
          404,
          ResponseMessage.NO_VEHICLE_RECORD
        );
      }

      if (!location) {
        return Response.customResponse(
          res,
          404,
          ResponseMessage.NO_LOCATION_RECORD
        );
      }

      const uniqueCode = unique.randomCode();
      const hashedPassword = unique.passwordHash(body.password);

      const phone = new Phone({});
      phone.code = body.phone.code;
      phone.number = body.phone.number;

      const address = new Address({});
      address.city = body.address.city;
      address.country = body.address.country;
      address.region = body.address.region;

      const pilot = new Driver({
        roleId: body.roleId,
        vehicleId: body.vehicleId,
        locationId: body.locationId,
        code: "DR" + uniqueCode,
        name: body.name,
        email: body.email,
        password: hashedPassword,
        phone: phone,
        address: address,
        createdAt: DateUtil.currentDate(),
      });

      const newPilot = await pilot.save();

      const action = `New ${moduleName} - ${"DR" + uniqueCode}`;
      const person = body.actionBy;

      await createActivityLog(moduleName, action, person);

      return res.status(res.statusCode).json(newPilot);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  getAll: async (req, res) => {
    try {
      const totalDrivers = await Driver.countDocuments();
      const { pagination, skip } = await PaginationUtiliy.paginationParams(
        req,
        totalDrivers
      );

      if (pagination.page > pagination.pages) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.OUTOF_DATA
        );
      }

      pagination.data = await Driver.find()
        .populate([
          { path: "role", select: "name claims" },
          { path: "vehicle", select: "vehicleModel" },
          { path: "location", select: "subcity" },
        ])
        .select("-password")
        .sort({ _id: -1 })
        .skip(skip)
        .limit(pagination.pageSize);

      if (totalDrivers === 0) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.NO_DATA
        );
      }

      pagination.data = pagination.data.map((item) => ({
        ...item.toJSON(),
        role: item.role ? item.role.name : null,
        permissions: item.role ? item.role.claims : null,
        location: item.location ? item.location.subcity : null,
        vehicle: item.vehicle ? item.vehicle.vehicleModel : null,
      }));

      return Response.paginationResponse(res, res.statusCode, pagination);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  get: async (req, res) => {
    try {
      const pilot = await Driver.findById(req.params.id)
        .select("-password")
        .populate([
          { path: "role", select: "name claims" },
          { path: "vehicle", select: "vehicleModel" },
          { path: "location", select: "subcity" },
        ]);

      if (!pilot) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      const phone = new Phone({});
      phone.code = pilot.phone.code;
      phone.number = pilot.phone.number;

      const address = new Address({});
      address.city = pilot.address.city;
      address.country = pilot.address.country;
      address.region = pilot.address.region;

      const pilotData = {
        id: pilot._id,
        phone: phone,
        address: address,
        code: pilot.code,
        name: pilot.name,
        email: pilot.email,
        status: pilot.status,
        createdAt: pilot.createdAt,
        updatedAt: pilot.updatedAt,
        role: pilot.role ? pilot.role.name : null,
        permissions: pilot.role ? pilot.role.claims : null,
        location: pilot.location ? pilot.location.subcity : null,
        vehicle: pilot.vehicle ? pilot.vehicle.vehicleModel : null,
      };

      return Response.successResponse(res, res.statusCode, pilotData);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  update: async (req, res) => {
    try {
      const body = req.body;
      const pilot = await Driver.findById(body.id);

      if (!pilot) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      pilot.address.country = body.address.country || pilot.address.country;
      pilot.address.region = body.address.region || pilot.address.region;
      pilot.address.city = body.address.city || pilot.address.city;
      pilot.locationId = body.locationId || pilot.locationId;
      pilot.vehicleId = body.vehicleId || pilot.vehicleId;
      pilot.status = body.status || pilot.status;
      pilot.email = body.email || pilot.email;
      pilot.name = body.name || pilot.name;
      pilot.updatedAt = DateUtil.currentDate();

      const updatedPilot = await pilot.save();

      const action = `Updated ${moduleName} - ${pilot.code}`;
      const person = body.actionBy;

      await createActivityLog(moduleName, action, person);

      return res.status(res.statusCode).json(updatedPilot);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  delete: async (req, res) => {
    try {
      const param = req.params;
      const userId = param.actionBy;

      const pilot = await Driver.findById(param.id);

      if (!pilot) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      await pilot.deleteOne();

      const action = `Deleted ${moduleName} - ${pilot.code}`;
      await createActivityLog(moduleName, action, userId);

      return res.status(res.statusCode).json({
        message: ResponseMessage.SUCCESS_MESSAGE,
      });
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  changePassword: async (req, res) => {
    await changePassword(req, res, Driver, moduleName);
  },

  resetPassword: async (req, res) => {
    await resetPassword(req, res, Driver, moduleName);
  },

  login: async (req, res) => {
    await login(req, res, Driver);
  },
};
