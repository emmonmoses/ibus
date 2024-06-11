// MODELS
const Timing = require("../../models/timing");

// VALIDATIONS
const { timingValidation } = require("../../validations/timing");

// UTILITIES
const DateUtil = require("../../utilities/date_utility");
const Response = require("../../utilities/response_utility");
const ResponseMessage = require("../../utilities/messages_utility");
const PaginationUtility = require("../../utilities/pagination_utility");
const { createActivityLog } = require("../../utilities/activitylog_utility");

const moduleName = `Timing`;

module.exports = {
    create: async (req, res) => {
        try {
            const body = req.body;
            const { error } = timingValidation(body);

            if (error) {
                return Response.sendValidationErrorMessage(res, 400, error);
            }

            const existingTiming = await Timing.findOne({
                name: body.name,
            });

            if (existingTiming) {
                return Response.customResponse(res, 409, ResponseMessage.DATA_EXISTS);
            }

            const timing = new Timing({
                name: body.name,
                status: body.status,
                createdAt: DateUtil.currentDate(),
                updatedAt: DateUtil.currentDate(),
            });

            const newTiming = await timing.save();

            const action = `New ${moduleName} - ${body.name}`;
            const person = body.actionBy;

            await createActivityLog(moduleName, action, person);

            return res.status(res.statusCode).json(newTiming);
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    getAll: async (req, res) => {
        try {
            const totalTimings = await Timing.countDocuments();
            const { pagination, skip } = await PaginationUtility.paginationParams(
                req,
                totalTimings
            );

            if (pagination.page > pagination.pages) {
                return Response.customResponse(
                    res,
                    res.statusCode,
                    ResponseMessage.OUTOF_DATA
                );
            }

            pagination.data = await Timing.find()
                .sort({ _id: -1 })
                .skip(skip)
                .limit(pagination.pageSize);

            if (totalTimings === 0) {
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
            const timing = await Timing.findById(req.params.id);

            if (!timing) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            const timingData = {
                id: timing._id,
                name: timing.name,
                status: timing.status,
                createdAt: timing.createdAt
            };

            return Response.successResponse(res, res.statusCode, timingData);
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    update: async (req, res) => {
        try {
            const body = req.body;
            const timing = await Timing.findById(body.id);

            if (!timing) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            timing.name = body.name || timing.name;
            timing.status = body.status || timing.status;
            timing.actionBy = body.actionBy || timing.actionBy;
            timing.updatedAt = DateUtil.currentDate();

            const updatedTiming = await timing.save();

            const action = `Updated ${moduleName} - ${timing.name}`;
            const person = body.actionBy;

            await createActivityLog(moduleName, action, person);

            return res.status(res.statusCode).json(updatedTiming);
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    delete: async (req, res) => {
        try {
            const param = req.params;
            const userId = param.actionBy;

            const timing = await Timing.findById(param.id);

            if (!timing) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            await timing.deleteOne();

            const action = `Deleted ${moduleName} - ${timing.name}`;
            await createActivityLog(moduleName, action, userId);

            return res.status(res.statusCode).json({
                message: ResponseMessage.SUCCESS_MESSAGE,
            });
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },
};