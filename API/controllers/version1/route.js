// MODELS
const Route = require("../../models/route");

// VALIDATIONS
const { routeValidation } = require("../../validations/route");

// UTILITIES
const DateUtil = require("../../utilities/date_utility");
const Response = require("../../utilities/response_utility");
const ResponseMessage = require("../../utilities/messages_utility");
const PaginationUtility = require("../../utilities/pagination_utility");
const { createActivityLog } = require("../../utilities/activitylog_utility");

const moduleName = `Route`;

module.exports = {
    create: async (req, res) => {
        try {
            const body = req.body;
            const { error } = routeValidation(body);

            if (error) {
                return Response.sendValidationErrorMessage(res, 400, error);
            }

            const existingRoute = await Route.findOne({
                pickupLocationId: body.pickupLocationId,
                dropLocationId: body.dropLocationId,
                vehicleTypeId: body.vehicleTypeId,
            });

            if (existingRoute) {
                return Response.customResponse(res, 409, ResponseMessage.DATA_EXISTS);
            }

            const route = new Route({
                name: body.name,
                status: body.status,
                pickupLocationId: body.pickupLocationId,
                dropLocationId: body.dropLocationId,
                vehicleTypeId: body.vehicleTypeId,
                price: body.price,
                createdAt: DateUtil.currentDate(),
                updatedAt: DateUtil.currentDate(),
            });

            const newRoute = await route.save();

            const action = `New ${moduleName} - ${body.name}`;
            const person = body.actionBy;

            await createActivityLog(moduleName, action, person);

            return res.status(res.statusCode).json(newRoute);
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    getAll: async (req, res) => {
        try {
            const totalRoutes = await Route.countDocuments();
            const { pagination, skip } = await PaginationUtility.paginationParams(
                req,
                totalRoutes
            );

            if (pagination.page > pagination.pages) {
                return Response.customResponse(
                    res,
                    res.statusCode,
                    ResponseMessage.OUTOF_DATA
                );
            }

            pagination.data = await Route.find()
                .populate([
                    { path: "pickupLocation" },
                    { path: "dropLocation" },
                    { path: "vehicle" },
                ])
                .sort({ _id: -1 })
                .skip(skip)
                .limit(pagination.pageSize);

            if (totalRoutes === 0) {
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
            const route = await Route.findById(req.params.id)
                .select()
                .populate([
                    { path: "pickupLocation" },
                    { path: "dropLocation" },
                    { path: "vehicle" },
                ]);

            if (!route) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            const routeData = {
                id: route._id,
                name: route.name,
                status: route.status,
                createdAt: route.createdAt,
                updatedAt: route.updatedAt,
                pickupLocation: route.pickupLocation,
                dropLocationId: route.dropLocation,
                vehicleTypeId: route.vehicle
            };

            return Response.successResponse(res, res.statusCode, routeData);
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    update: async (req, res) => {
        try {
            const body = req.body;
            const route = await Route.findById(body.id);

            if (!route) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            route.name = body.name || route.name;
            route.status = body.status || route.status;
            route.pickupLocationId = body.pickupLocationId || route.pickupLocationId;
            route.dropLocationId = body.dropLocationId || route.dropLocationId;
            route.vehicleTypeId = body.vehicleTypeId || route.vehicleTypeId;
            route.price = body.price || route.price;
            route.updatedAt = DateUtil.currentDate();

            const updatedRoute = await route.save();

            const action = `Updated ${moduleName} - ${route.name}`;
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
            const userId = param.actionBy;

            const route = await Route.findById(param.id);

            if (!route) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            await route.deleteOne();

            const action = `Deleted ${moduleName} - ${route.name}`;
            await createActivityLog(moduleName, action, userId);

            return res.status(res.statusCode).json({
                message: ResponseMessage.SUCCESS_MESSAGE,
            });
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },
};