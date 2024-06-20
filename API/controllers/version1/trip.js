// MODELS
const Trip = require("../../models/trip");
const Route = require("../../models/route");
const Timing = require("../../models/timing");
const Driver = require("../../models/driver");
const Vehicle = require("../../models/vehicle");
const Customer = require("../../models/customer");
const TripType = require("../../models/tripType");

// VALIDATIONS
const { tripValidation } = require("../../validations/trip");

// UTILITIES
const DateUtil = require("../../utilities/date_utility");
const Response = require("../../utilities/response_utility");
const unique = require("../../utilities/codegenerator_utility");
const ResponseMessage = require("../../utilities/messages_utility");
const PaginationUtility = require("../../utilities/pagination_utility");
const { createActivityLog } = require("../../utilities/activitylog_utility");

const moduleName = `Trip`;

module.exports = {
  create: async (req, res) => {
    try {
      const body = req.body;
      const { error } = tripValidation(body);

      if (error) {
        return Response.sendValidationErrorMessage(res, 400, error);
      }

      const existingTrip = await Trip.findOne({
        routeId: body.routeId,
        timingId: body.timingId,
        vehicleId: body.vehicleId,
        tripTypeId: body.tripTypeId,
      });

      if (existingTrip) {
        return Response.customResponse(res, 409, ResponseMessage.DATA_EXISTS);
      }
      // Check if all customer IDs exist
      const customerIds = body.customers.map((customer) => customer.id);
      const customersExistenceCheck = await Promise.all(
        customerIds.map((id) => Customer.findById(id))
      );

      for (const customer of customersExistenceCheck) {
        if (!customer) {
          return Response.customResponse(
            res,
            404,
            ResponseMessage.NO_CUSTOMER_RECORD
          );
        }
      }

      const assignedDriver = "";
      const route = await Route.findById(body.routeId);
      const timing = await Timing.findById(body.timingId);
      const vehicle = await Vehicle.findById(body.vehicleId);
      const tripType = await TripType.findById(body.tripTypeId);
      const driver = await Driver.find({
        routeId: body.routeId,
        timingId: body.timingId,
        vehicleId: body.vehicleId,
        tripTypeId: body.tripTypeId,
      });

      if (!route) {
        return Response.customResponse(
          res,
          404,
          ResponseMessage.NO_ROUTE_RECORD
        );
      }

      if (!timing) {
        return Response.customResponse(
          res,
          404,
          ResponseMessage.NO_TIMING_RECORD
        );
      }

      if (!vehicle) {
        return Response.customResponse(
          res,
          404,
          ResponseMessage.NO_VEHICLE_RECORD
        );
      }

      if (!tripType) {
        return Response.customResponse(
          res,
          404,
          ResponseMessage.NO_TRIPTYPE_RECORD
        );
      }

      if (!driver) {
        return Response.customResponse(
          res,
          404,
          ResponseMessage.NO_DRIVER_RECORD
        );
      } else {
        assignedDriver = body.driverId;
      }

      const uniqueCode = unique.randomCode();

      const trip = new Trip({
        code: "TR" + uniqueCode,
        description: body.description,
        customers: body.customers.map((csr) => ({
          id: csr.id,
        })),
        routeId: body.routeId,
        timingId: body.timingId,
        vehicleId: body.vehicleId,
        tripTypeId: body.tripTypeId,
        driverId: assignedDriver,
        status: body.status || false,
        createdAt: DateUtil.currentDate(),
      });

      const newTrip = await trip.save();

      const action = `New ${moduleName} - ${"TR" + uniqueCode}`;
      const tripSubscription = body.actionBy;

      await createActivityLog(moduleName, action, tripSubscription);

      return res.status(res.statusCode).json(newTrip);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  getTrips: async (req, res) => {
    try {
      const totalUsers = await Trip.countDocuments();
      const { pagination, skip } = await PaginationUtility.paginationParams(
        req,
        totalUsers
      );

      if (pagination.page > pagination.pages) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.OUTOF_DATA
        );
      }

      pagination.data = await Trip.find()
        // .populate([{ path: "customer", select: "name claims" }])
        .select("-customers.password,-driver.password")
        .populate([
          { path: "route" },
          { path: "timing" },
          { path: "driver" },
          { path: "vehicle" },
          { path: "customer" },
          { path: "tripType" },
        ])
        .sort({ _id: -1 })
        .skip(skip)
        .limit(pagination.pageSize);

      if (totalUsers === 0) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.NO_DATA
        );
      }

      pagination.data = pagination.data.map((item) => ({
        ...item.toJSON(),
        customer: item.customer ? item.customer.name : null,
        permissions: item.customer ? item.customer.claims : null,
      }));

      return Response.paginationResponse(res, res.statusCode, pagination);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  getTripsByCustomer: async (req, res) => {
    try {
      const customer = await Customer.findById(req.params.id);

      if (!customer) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      const roleId = customer._id;
      const totalUsers = await Trip.countDocuments({ roleId: roleId });
      const { pagination, skip } = await PaginationUtility.paginationParams(
        req,
        totalUsers
      );

      if (pagination.page > pagination.pages) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.OUTOF_DATA
        );
      }

      pagination.data = await Trip.find({ roleId: roleId })
        // .populate([{ path: "customer", select: "name claims" }])
        .select("-customers.password,-driver.password")
        .populate([
          { path: "route" },
          { path: "timing" },
          { path: "driver" },
          { path: "vehicle" },
          { path: "customer" },
          { path: "tripType" },
        ])
        .sort({ _id: -1 })
        .skip(skip)
        .limit(pagination.pageSize);

      if (totalUsers === 0) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.NO_DATA
        );
      }

      pagination.data = pagination.data.map((item) => ({
        ...item.toJSON(),
        customer: item.customer ? item.customer.name : null,
        permissions: item.customer ? item.customer.claims : null,
      }));

      return Response.paginationResponse(res, res.statusCode, pagination);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  getTripsByDriver: async (req, res) => {
    try {
      const customer = await Customer.findById(req.params.id);

      if (!customer) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      const roleId = customer._id;
      const totalUsers = await Trip.countDocuments({ roleId: roleId });
      const { pagination, skip } = await PaginationUtility.paginationParams(
        req,
        totalUsers
      );

      if (pagination.page > pagination.pages) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.OUTOF_DATA
        );
      }

      pagination.data = await Trip.find({ roleId: roleId })
        // .populate([{ path: "customer", select: "name claims" }])
        .select("-customers.password,-driver.password")
        .populate([
          { path: "route" },
          { path: "timing" },
          { path: "driver" },
          { path: "vehicle" },
          { path: "customer" },
          { path: "tripType" },
        ])
        .sort({ _id: -1 })
        .skip(skip)
        .limit(pagination.pageSize);

      if (totalUsers === 0) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.NO_DATA
        );
      }

      pagination.data = pagination.data.map((item) => ({
        ...item.toJSON(),
        customer: item.customer ? item.customer.name : null,
        permissions: item.customer ? item.customer.claims : null,
      }));

      return Response.paginationResponse(res, res.statusCode, pagination);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  switchRoute: async (req, res) => {
    try {
      const body = req.body;
      const trip = await Trip.findById(body.id);

      if (!trip) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      trip.routeId = body.newRoute || trip.routeId;
      trip.actionBy = body.userId || trip.actionBy;
      trip.updatedAt = DateUtil.currentDate();

      const updatedRoute = await trip.save();

      const action = `Updated ${moduleName} - ${trip.code}`;
      const actor = body.actionBy;

      await createActivityLog(moduleName, action, actor);

      return res.status(res.statusCode).json(updatedRoute);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  get: async (req, res) => {
    try {
      const trip = await Trip.findById(req.params.id)
        .select("-customers.password, -driver.password")
        .populate([
          { path: "route" },
          { path: "timing" },
          { path: "driver" },
          { path: "vehicle" },
          { path: "customer" },
          { path: "tripType" },
        ]);

      if (!trip) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      const tripData = {
        id: trip._id,
        code: trip.code,
        status: trip.status,
        createdAt: trip.createdAt,
        description: trip.description,
        route: trip.route ? trip.route.name : null,
        timing: trip.timing ? trip.timing.name : null,
        driver: trip.driver ? trip.driver.name : null,
        vehicle: trip.vehicle ? trip.vehicle.name : null,
        customer: trip.customer ? trip.customer.name : null,
        tripType: trip.tripType ? trip.tripType.name : null,
      };

      return Response.successResponse(res, res.statusCode, tripData);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  update: async (req, res) => {
    try {
      const body = req.body;
      const trip = await Trip.findById(body.id);

      if (!trip) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      trip.updatedAt = DateUtil.currentDate();
      trip.timingId = body.timing || trip.timingId;
      trip.vehicleId = body.vehicle || trip.vehicleId;
      trip.tripTypeId = body.tripTypeId || trip.tripTypeId;
      trip.description = body.description || trip.description;

      const updatedRoute = await trip.save();

      const action = `Updated ${moduleName} - ${trip.code}`;
      const person = body.actionBy;

      await createActivityLog(moduleName, action, person);

      return res.status(res.statusCode).json(updatedRoute);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  delete: async (req, res) => {
    try {
      const param = req.params;
      const userId = param.userId;

      const trip = await Trip.findById(param.id);

      if (!trip) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      await trip.deleteOne();

      const action = `Deleted ${moduleName} - ${trip.code}`;
      await createActivityLog(moduleName, action, userId);

      return res.status(res.statusCode).json({
        message: ResponseMessage.SUCCESS_MESSAGE,
      });
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },
};
