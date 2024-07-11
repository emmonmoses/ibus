// MODELS
const TripType = require("../../models/tripType");

// VALIDATIONS
const { tripTypeValidation } = require("../../validations/tripType");

// UTILITIES
const DateUtil = require("../../utilities/date_utility");
const Response = require("../../utilities/response_utility");
const ResponseMessage = require("../../utilities/messages_utility");
const PaginationUtility = require("../../utilities/pagination_utility");
const { createActivityLog } = require("../../utilities/activitylog_utility");

const moduleName = `TripType`;

module.exports = {
    create: async (req, res) => {
        try {
            const body = req.body;
            const { error } = tripTypeValidation(body);

            if (error) {
                return Response.sendValidationErrorMessage(res, 400, error);
            }

            const existingTripType = await TripType.findOne({
                name: body.name,
            });

            if (existingTripType) {
                return Response.customResponse(res, 409, ResponseMessage.DATA_EXISTS);
            }

            const tripType = new TripType({
                name: body.name,
                status: body.status,
                createdAt: DateUtil.currentDate(),
                updatedAt: DateUtil.currentDate(),
            });

            const newTripType = await tripType.save();

            const action = `New ${moduleName} - ${body.name}`;
            const person = body.actionBy;

            await createActivityLog(moduleName, action, person);

            return res.status(res.statusCode).json(newTripType);
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    getAll: async (req, res) => {
        try {
            const totalTripTypes = await TripType.countDocuments();
            const { pagination, skip } = await PaginationUtility.paginationParams(
                req,
                totalTripTypes
            );

            if (pagination.page > pagination.pages) {
                return Response.customResponse(
                    res,
                    res.statusCode,
                    ResponseMessage.OUTOF_DATA
                );
            }

            pagination.data = await TripType.find()
                .sort({ _id: -1 })
                .skip(skip)
                .limit(pagination.pageSize);

            if (totalTripTypes === 0) {
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

    get: async (req, res) => {
        try {
            const tripType = await TripType.findById(req.params.id);

            if (!tripType) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            const tripTypeData = {
                id: tripType._id,
                name: tripType.name,
                status: tripType.status,
                createdAt: tripType.createdAt
            };

            return Response.successResponse(res, res.statusCode, tripTypeData);
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    update: async (req, res) => {
        try {
            const body = req.body;
            const tripType = await TripType.findById(body.id);

            if (!tripType) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            tripType.name = body.name || tripType.name;
            tripType.status = body.status || tripType.status;
            tripType.actionBy = body.actionBy || tripType.actionBy;
            tripType.updatedAt = DateUtil.currentDate();

            const updatedTripType = await tripType.save();

            const action = `Updated ${moduleName} - ${tripType.name}`;
            const person = body.actionBy;

            await createActivityLog(moduleName, action, person);

            return res.status(res.statusCode).json(updatedTripType);
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    delete: async (req, res) => {
        try {
            const param = req.params;
            const userId = param.actionBy;

            const tripType = await TripType.findById(param.id);

            if (!tripType) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            await tripType.deleteOne();

            const action = `Deleted ${moduleName} - ${tripType.name}`;
            await createActivityLog(moduleName, action, userId);

            return res.status(res.statusCode).json({
                message: ResponseMessage.SUCCESS_MESSAGE,
            });
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },
};