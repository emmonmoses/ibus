// MODELS
const Vehicle = require("../../models/vehicle");

// VALIDATIONS
const { vehicleValidation } = require("../../validations/vehicle");

// UTILITIES
const DateUtil = require("../../utilities/date_utility");
const Response = require("../../utilities/response_utility");
const ResponseMessage = require("../../utilities/messages_utility");
const PaginationUtility = require("../../utilities/pagination_utility");
const { createActivityLog } = require("../../utilities/activitylog_utility");

const moduleName = `Vehicle`;

module.exports = {
  create: async (req, res) => {
    try {
      const body = req.body;
      const { error } = vehicleValidation(body);

      if (error) {
        return Response.sendValidationErrorMessage(res, 400, error);
      }

      const existingVehicle = await Vehicle.findOne({
        vehicleType: body.vehicleType,
        vehicleCapacity: body.vehicleCapacity,
      });

      if (existingVehicle) {
        return Response.customResponse(res, 409, ResponseMessage.DATA_EXISTS);
      }

      const vehicles = new Vehicle({
        vehicleType: body.vehicleType,
        vehicleModel: body.vehicleModel,
        vehicleCapacity: body.vehicleCapacity,
        status: body.status,
        createdAt: DateUtil.currentDate(),
      });

      const newArea = await vehicles.save();

      const action = `New ${moduleName} - ${body.vehicleType + ":" + body.vehicleCapacity}`;
      const person = body.actionBy;

      await createActivityLog(moduleName, action, person);

      return res.status(res.statusCode).json(newArea);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  getVehicles: async (req, res) => {
    try {
      const totalVehicles = await Vehicle.countDocuments();
      const { pagination, skip } = await PaginationUtility.paginationParams(
        req,
        totalVehicles
      );

      if (pagination.page > pagination.pages) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.OUTOF_DATA
        );
      }

      pagination.data = await Vehicle.find()
        .sort({ _id: -1 })
        .skip(skip)
        .limit(pagination.pageSize);

      if (totalVehicles === 0) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.NO_DATA
        );
      }

      return Response.paginationResponse(res, res.statusCode, pagination);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  searchVehicles: async (req, res) => {
    try {
      const city = req.params.city;

      const totalVehicles = await Vehicle.countDocuments({ city: city });
      const { pagination, skip } = await PaginationUtility.paginationParams(
        req,
        totalVehicles
      );

      if (pagination.page > pagination.pages) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.OUTOF_DATA
        );
      }

      const locations = await Vehicle.find({ city: city })
        .sort({ _id: -1 })
        .skip(skip)
        .limit(pagination.pageSize);

      if (totalVehicles === 0) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.NO_DATA
        );
      }

      const formattedLocations = locations.map((location) => ({
        city: location.city,
        subcity: location.subcity,
        woreda: location.woreda,
        status: location.status,
        createdAt: location.createdAt,
        id: location._id,
      }));

      const jsonResponse = {
        page: pagination.page,
        pages: pagination.pages,
        pageSize: pagination.pageSize,
        rows: totalVehicles,
        data: formattedLocations,
      };

      return Response.paginationResponse(res, res.statusCode, jsonResponse);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  get: async (req, res) => {
    try {
      const vehicles = await Vehicle.findById(req.params.id);

      if (!vehicles) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      const vehicleData = {
        id: vehicles._id,
        vehicleType: vehicles.vehicleType,
        vehicleModel: vehicles.vehicleModel,
        vehicleCapacity: vehicles.vehicleCapacity,
        createdAt: vehicles.createdAt,
        status: vehicles.status,
      };

      return Response.successResponse(res, res.statusCode, vehicleData);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  update: async (req, res) => {
    try {
      const body = req.body;
      const vehicles = await Vehicle.findById(body.id);

      if (!vehicles) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      vehicles.vehicleType = body.vehicleType || vehicles.vehicleType;
      vehicles.vehicleModel = body.vehicleModel || vehicles.vehicleModel;
      vehicles.vehicleCapacity =
        body.vehicleCapacity || vehicles.vehicleCapacity;
      vehicles.status = body.status;
      vehicles.actionBy = body.actionBy || vehicles.actionBy;
      vehicles.updatedAt = DateUtil.currentDate();

      const updatedVehicle = await vehicles.save();

      const action = `Updated ${moduleName} - ${vehicles.vehicleType + ":" + vehicles.vehicleCapacity}`;
      const person = body.actionBy;

      await createActivityLog(moduleName, action, person);

      return res.status(res.statusCode).json(updatedVehicle);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  delete: async (req, res) => {
    try {
      const param = req.params;
      const userId = param.actionBy;

      const vehicles = await Vehicle.findById(param.id);

      if (!vehicles) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      await vehicles.deleteOne();

      const action = `Deleted ${moduleName} - ${
        vehicles.vehicleType + ":" + vehicles.vehicleCapacity
      }`;

      await createActivityLog(moduleName, action, userId);

      return res.status(res.statusCode).json({
        message: ResponseMessage.SUCCESS_MESSAGE,
      });
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },
};
