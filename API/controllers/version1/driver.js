// MODELS
const Role = require("../../models/role");
const Phone = require("../../models/phone");
const Driver = require("../../models/driver");
const Address = require("../../models/address");
const Vehicle = require("../../models/vehicle");
const Location = require("../../models/location");
const Route = require("../../models/route");
const Timing = require("../../models/timing");
const TripType = require("../../models/tripType");

// VALIDATIONS
const { driverValidation } = require("../../validations/driver");

// UTILITIES
const DateUtil = require("../../utilities/date_utility");
const { login } = require("../../utilities/login_utility");
const Response = require("../../utilities/response_utility");
const unique = require("../../utilities/codegenerator_utility");
const ResponseMessage = require("../../utilities/messages_utility");
const PaginationUtility = require("../../utilities/pagination_utility");
const { resetPassword } = require("../../utilities/resetpassword_utility");
const { changePassword } = require("../../utilities/changepassword_utility");
const { createActivityLog } = require("../../utilities/activitylog_utility");

const moduleName = `Driver`;

module.exports = {
  create: async (req, res) => {
    console.log("REACHEDDD");
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
      //const location = await Location.findById(body.locationId);
      const route = await Route.findById(body.routeId);
      const timing = await Timing.findById(body.timingId);
      const tripType = await TripType.findById(body.tripTypeId);

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

      // if (!location) {
      //   return Response.customResponse(
      //     res,
      //     404,
      //     ResponseMessage.NO_LOCATION_RECORD
      //   );
      // }

      if (!route) {
        return Response.customResponse(
          res,
          404,
          ResponseMessage.NO_LOCATION_RECORD
        );
      }

      if (!timing) {
        return Response.customResponse(
          res,
          404,
          ResponseMessage.NO_LOCATION_RECORD
        );
      }

      if (!tripType) {
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
        //locationId: body.locationId,
        code: "DR" + uniqueCode,
        routeId: body.routeId,
        timingId: body.timingId,
        tripTypeId: body.tripTypeId,
        drivingLicense: body.drivingLicense,
        plateNumber: body.plateNumber,
        plateNumberCode: body.plateNumberCode,
        businessLicense: body.businessLicense,
        isAssigned: body.isAssigned,
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
      const { pagination, skip } = await PaginationUtility.paginationParams(
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
          { path: "role", select: "name" },
          { path: "route", select: "name" },
          { path: "timing", select: "name" },
          { path: "vehicle", select: "name" },
          { path: "tripType", select: "name" },
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
        route: item.route ? item.route.name : null,
        timing: item.timing ? item.timing.name : null,
        vehicle: item.vehicle ? item.vehicle.name : null,
        tripType: item.tripType ? item.tripType.name : null,
      }));

      return Response.paginationResponse(res, res.statusCode, pagination);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  filterDrivers: async (req, res) => {
    try {
      const param = req.params;

      const drivers = await Driver.find({
        routeId: param.routeId,
        timingId: param.timingId,
        vehicleId: param.vehicleId,
        tripTypeId: param.tripTypeId,
      });

      if (!drivers) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      const totalDrivers = await Driver.countDocuments({
        routeId: param.routeId,
        timingId: param.timingId,
        vehicleId: param.vehicleId,
        tripTypeId: param.tripTypeId,
      });

      const { pagination, skip } = await PaginationUtility.paginationParams(
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

      pagination.data = await Driver.find({
        routeId: param.routeId,
        timingId: param.timingId,
        vehicleId: param.vehicleId,
        tripTypeId: param.tripTypeId,
      })
        .populate([
          { path: "role", select: "name" },
          { path: "route", select: "name" },
          { path: "timing", select: "name" },
          { path: "vehicle", select: "name" },
          { path: "tripType", select: "name" },
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
        route: item.route ? item.route.name : null,
        timing: item.timing ? item.timing.name : null,
        vehicle: item.vehicle ? item.vehicle.name : null,
        tripType: item.tripType ? item.tripType.name : null,
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
          { path: "role", select: "name" },
          { path: "route", select: "name" },
          { path: "timing", select: "name" },
          { path: "vehicle", select: "name" },
          { path: "tripType", select: "name" },
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
        drivingLicense: pilot.drivingLicense,
        plateNumber: pilot.plateNumber,
        plateNumberCode: pilot.plateNumberCode,
        businessLicense: pilot.businessLicense,
        isAssigned: pilot.isAssigned,
        vehicle: pilot.vehicle,
        route: pilot.route,
        timing: pilot.timing,
        tripType: pilot.tripType,
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
      pilot.isAssigned = body.isAssigned;
      pilot.vehicleId = body.vehicleId || pilot.vehicleId;
      pilot.routeId = body.routeId || pilot.routeId;
      (pilot.timingId = body.timingId || pilot.timingId),
        (pilot.tripTypeId = body.tripTypeId || pilot.tripTypeId);

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
