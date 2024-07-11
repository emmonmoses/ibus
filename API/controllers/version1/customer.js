// MODELS
const Role = require("../../models/role");
const Customer = require("../../models/customer");
const Pagination = require("../../models/pagination");
const Phone = require("../../models/phone");
const Address = require("../../models/address");

// VALIDATIONS
const { customerValidation } = require("../../validations/customer");

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

const moduleName = `Customer`;

module.exports = {
  create: async (req, res) => {
    try {
      const body = req.body;
      const { error } = customerValidation(body);

      if (error) {
        return Response.sendValidationErrorMessage(res, 400, error);
      }

      const existingUser = await Customer.findOne({
        email: body.username,
        name: body.name,
      });

      if (existingUser) {
        return Response.customResponse(res, 409, ResponseMessage.DATA_EXISTS);
      }

      const role = await Role.findById(body.roleId);

      if (!role) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
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

      const customer = new Customer({
        roleId: body.roleId,
        routeId: body.routeId,
        timingId: body.timingId,
        tripTypeId: body.tripTypeId,
        code: "CU" + uniqueCode,
        name: body.name,
        email: body.email,
        password: hashedPassword,
        phone: phone,
        address: address,
        createdAt: DateUtil.currentDate(),
        updatedAt: DateUtil.currentDate(),
      });

      const newCustomer = await customer.save();

      const action = `New ${moduleName} - ${"C" + uniqueCode}`;
      const person = body.actionBy;

      await createActivityLog(moduleName, action, person);

      return res.status(res.statusCode).json(newCustomer);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  getAll: async (req, res) => {
    try {
      const totalCustomers = await Customer.countDocuments();
      const { pagination, skip } = await PaginationUtility.paginationParams(
        req,
        totalCustomers
      );

      if (pagination.page > pagination.pages) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.OUTOF_DATA
        );
      }

      pagination.data = await Customer.find()
        .populate([
          { path: "role", select: "name description" },
          { path: "route", select: "name status price" },
          { path: "time", select: "name status" },
          { path: "tripType", select: "name status" },
        ])
        .select("-password")
        .sort({ _id: -1 })
        .skip(skip)
        .limit(pagination.pageSize);

      if (totalCustomers === 0) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.NO_DATA
        );
      }

      pagination.data = pagination.data.map((item) => ({
        ...item.toJSON(),
        // role: item.role ? item.role.name : null,
        permissions: item.role ? item.role.claims : null,
      }));

      return Response.paginationResponse(res, res.statusCode, pagination);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  get: async (req, res) => {
    try {
      const customer = await Customer.findById(req.params.id)
        .select("-password")
        .populate([
          { path: "role", select: "name description" },
          { path: "route", select: "name status price" },
          { path: "time", select: "name status" },
          { path: "tripType", select: "name status" },
        ]);

      if (!customer) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      const phone = new Phone({});
      phone.code = customer.phone.code;
      phone.number = customer.phone.number;

      const address = new Address({});
      address.city = customer.address.city;
      address.country = customer.address.country;
      address.region = customer.address.region;

      const customerData = {
        phone: phone,
        address: address,
        code: customer.code,
        name: customer.name,
        email: customer.email,
        status: customer.status,
        createdAt: customer.createdAt,
        updatedAt: customer.updatedAt,
        id: customer._id,
        role: customer.role ? customer.role : null,
        route: customer.route ? customer.route : null,
        time: customer.time ? customer.time : null,
        tripType: customer.tripType ? customer.tripType : null,
        permissions: customer.role ? customer.role.claims : null,
      };

      return Response.successResponse(res, res.statusCode, customerData);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  update: async (req, res) => {
    try {
      const body = req.body;
      const customer = await Customer.findById(body.id);

      if (!customer) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      customer.address.city = body.address.city || customer.address.city;
      customer.address.country =
        body.address.country || customer.address.country;
      customer.address.region = body.address.region || customer.address.region;
      customer.name = body.name || customer.name;
      customer.email = body.email || customer.email;
      customer.status = body.status || customer.status;
      customer.updatedAt = DateUtil.currentDate();
      customer.routeId = body.routeId || customer.routeId;
      customer.timingId = body.timingId || customer.timinId;
      customer.tripTypeId = body.tripTypeId || customer.tripTypeId;

      const updatedCustomer = await customer.save();

      const action = `Updated ${moduleName} - ${customer.code}`;
      const person = body.actionBy;

      await createActivityLog(moduleName, action, person);

      return res.status(res.statusCode).json(updatedCustomer);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  delete: async (req, res) => {
    try {
      const param = req.params;
      const userId = param.customerId;

      const customer = await Customer.findById(param.id);

      if (!customer) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      await customer.deleteOne();

      const action = `Deleted ${moduleName} - ${customer.code}`;
      await createActivityLog(moduleName, action, userId);

      return res.status(res.statusCode).json({
        message: ResponseMessage.SUCCESS_MESSAGE,
      });
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  changePassword: async (req, res) => {
    await changePassword(req, res, Customer, moduleName);
  },

  resetPassword: async (req, res) => {
    await resetPassword(req, res, Customer, moduleName);
  },

  login: async (req, res) => {
    await login(req, res, Customer);
  },
};
