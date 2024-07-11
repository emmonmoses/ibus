// MODELS
const Location = require("../../models/location");

// VALIDATIONS
const { locationValidation } = require("../../validations/location");

// UTILITIES
const DateUtil = require("../../utilities/date_utility");
const Response = require("../../utilities/response_utility");
const ResponseMessage = require("../../utilities/messages_utility");
const PaginationUtility = require("../../utilities/pagination_utility");
const { createActivityLog } = require("../../utilities/activitylog_utility");

const moduleName = `Location`;

module.exports = {
  create: async (req, res) => {
    try {
      const body = req.body;
      const { error } = locationValidation(body);

      if (error) {
        return Response.sendValidationErrorMessage(res, 400, error);
      }

      const existingLocation = await Location.findOne({
        city: body.city,
        location: body.location,
      });

      if (existingLocation) {
        return Response.customResponse(res, 409, ResponseMessage.DATA_EXISTS);
      }

      const area = new Location({
        city: body.city,
        subcity: body.subcity,
        woreda: body.woreda,
        status: body.status,
        actionBy: body.actionBy,
        createdAt: DateUtil.currentDate(),
      });

      const newArea = await area.save();

      const action = `New ${moduleName} - ${body.city + ":" + body.woreda}`;
      const person = body.actionBy;

      await createActivityLog(moduleName, action, person);

      return res.status(res.statusCode).json(newArea);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  getLocations: async (req, res) => {
    try {
      const totalLocations = await Location.countDocuments();
      const { pagination, skip } = await PaginationUtility.paginationParams(
        req,
        totalLocations
      );

      if (pagination.page > pagination.pages) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.OUTOF_DATA
        );
      }

      pagination.data = await Location.find()
        .sort({ _id: -1 })
        .skip(skip)
        .limit(pagination.pageSize);

      if (totalLocations === 0) {
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

  getLocationsByCity: async (req, res) => {
    try {
      const city = req.params.city;

      const totalLocations = await Location.countDocuments({ city: city });
      const { pagination, skip } = await PaginationUtility.paginationParams(
        req,
        totalLocations
      );

      if (pagination.page > pagination.pages) {
        return Response.customResponse(
          res,
          res.statusCode,
          ResponseMessage.OUTOF_DATA
        );
      }

      const locations = await Location.find({ city: city })
        .sort({ _id: -1 })
        .skip(skip)
        .limit(pagination.pageSize);

      if (totalLocations === 0) {
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
        rows: totalLocations,
        data: formattedLocations,
      };

      return Response.paginationResponse(res, res.statusCode, jsonResponse);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  get: async (req, res) => {
    try {
      const area = await Location.findById(req.params.id);

      if (!area) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      const locationData = {
        id: area._id,
        city: area.city,
        subcity: area.subcity,
        woreda: area.woreda,
        createdAt: area.createdAt,
        status: area.status,
      };

      return Response.successResponse(res, res.statusCode, locationData);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  update: async (req, res) => {
    try {
      const body = req.body;
      const area = await Location.findById(body.id);

      if (!area) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      area.city = body.city || area.city;
      area.subcity = body.subcity || area.subcity;
      area.woreda = body.woreda || area.woreda;
      area.status = body.status;
      area.actionBy = body.actionBy || area.actionBy;
      area.updatedAt = DateUtil.currentDate();

      const updatedLocation = await area.save();

      const action = `Updated ${moduleName} - ${area.city + ":" + area.woreda}`;
      const person = body.actionBy;

      await createActivityLog(moduleName, action, person);

      return res.status(res.statusCode).json(updatedLocation);
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },

  delete: async (req, res) => {
    try {
      const param = req.params;
      const userId = param.actionBy;

      const area = await Location.findById(param.id);

      if (!area) {
        return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
      }

      await area.deleteOne();

      const action = `Deleted ${moduleName} - ${area.city + ":" + area.woreda}`;
      await createActivityLog(moduleName, action, userId);

      return res.status(res.statusCode).json({
        message: ResponseMessage.SUCCESS_MESSAGE,
      });
    } catch (err) {
      return Response.errorResponse(res, 500, err);
    }
  },
};
