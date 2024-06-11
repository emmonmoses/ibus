const Joi = require("joi");

const routeValidation = (data) => {
    const schema = Joi.object({
        name: Joi.string().required(),
        status: Joi.number().required(),
        pickupLocationId: Joi.string().required(),
        dropLocationId: Joi.string().required(),
        vehicleTypeId: Joi.string().required(),
        price: Joi.number().required(),
    });
    return schema.validate(data);
};

module.exports.routeValidation = routeValidation;