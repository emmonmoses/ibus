// MODELS
const Role = require("../../models/role");
const Company = require("../../models/company");
const Pagination = require("../../models/pagination");
const Phone = require("../../models/phone");
const Address = require("../../models/address");

// VALIDATIONS
const { companyValidation } = require("../../validations/company");

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

const moduleName = `Company`;

module.exports = {
    create: async (req, res) => {
        try {
            const body = req.body;
            const { error } = companyValidation(body);

            if (error) {
                return Response.sendValidationErrorMessage(res, 400, error);
            }

            const existingCompany = await Company.findOne({
                email: body.username,
                name: body.name,
            });

            if (existingCompany) {
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

            const company = new Company({
                roleId: body.roleId,
                code: "CO" + uniqueCode,
                name: body.name,
                email: body.email,
                password: hashedPassword,
                phone: phone,
                address: address,
                createdAt: DateUtil.currentDate(),
                updatedAt: DateUtil.currentDate(),
            });
            const newCompany = await company.save();

            const action = `New ${moduleName} - ${"CO" + uniqueCode}`;
            const person = body.actionBy;

            await createActivityLog(moduleName, action, person);

            return res.status(res.statusCode).json(newCompany);

        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    getAll: async (req, res) => {
        try {
            const totalCompanies = await Company.countDocuments();
            const { pagination, skip } = await PaginationUtility.paginationParams(
                req,
                totalCompanies
            );

            if (pagination.page > pagination.pages) {
                return Response.customResponse(
                    res,
                    res.statusCode,
                    ResponseMessage.OUTOF_DATA
                );
            }

            pagination.data = await Company.find()
                .populate({ path: "role", select: "name claims" })
                .select("-password")
                .sort({ _id: -1 })
                .skip(skip)
                .limit(pagination.pageSize);

            if (totalCompanies === 0) {
                return Response.customResponse(
                    res,
                    res.statusCode,
                    ResponseMessage.NO_DATA
                );
            }

            pagination.data = pagination.data.map((item) => ({
                ...item.toJSON(),
                role: {
                    id:item.role ? item.role.id : null,
                    name:item.role ? item.role.name : null,
                },                
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
            const company = await Company.findById(req.params.id)
                .select("-password")
                .populate([
                    {
                        path: "role",
                        select: "name claims",
                    },
                ]);

            if (!company) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            const phone = new Phone({});
            phone.code = company.phone.code;
            phone.number = company.phone.number;

            const address = new Address({});
            address.city = company.address.city;
            address.country = company.address.country;
            address.region = company.address.region;

            const companyData = {
                phone: phone,
                address: address,
                code: company.code,
                name: company.name,
                email: company.email,
                status: company.status,
                createdAt: company.createdAt,
                updatedAt: company.updatedAt,
                id: company._id,
                role: company.role ? company.role.name : null,
                permissions: company.role ? company.role.claims : null,
            };

            return Response.successResponse(res, res.statusCode, companyData);
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    update: async (req, res) => {
        try {
            const body = req.body;
            const company = await Company.findById(body.id);

            if (!company) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            company.address.city = body.address.city || company.address.city;
            company.address.region = body.address.region || company.address.region;
            company.address.country =
                body.address.country || company.address.country;
            company.name = body.name || company.name;
            company.email = body.email || company.email;
            company.status = body.status || company.status;
            company.phone.code = body.phone.code || company.phone.code;
            company.phone.number = body.phone.number || company.phone.number;
            company.updatedAt = DateUtil.currentDate();

            const updatedCompany = await company.save();

            const action = `Updated ${moduleName} - ${company.code}`;
            const person = body.actionBy;

            await createActivityLog(moduleName, action, person);

            return res.status(res.statusCode).json(updatedCompany);
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    delete: async (req, res) => {
        try {
            const param = req.params;
            const userId = param.companyId;

            const company = await Company.findById(param.id);

            if (!company) {
                return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
            }

            await company.deleteOne();

            const action = `Deleted ${moduleName} - ${company.code}`;
            await createActivityLog(moduleName, action, userId);

            return res.status(res.statusCode).json({
                message: ResponseMessage.SUCCESS_MESSAGE,
            });
        } catch (err) {
            return Response.errorResponse(res, 500, err);
        }
    },

    changePassword: async (req, res) => {
        await changePassword(req, res, Company, moduleName);
    },

    resetPassword: async (req, res) => {
        await resetPassword(req, res, Company, moduleName);
    },

    login: async (req, res) => {
        await login(req, res, Company);
    },
}