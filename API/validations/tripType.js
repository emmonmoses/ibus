const Joi = require("joi");

const tripTypeValidation = (data) => {
    const schema = Joi.object({
        name: Joi.string().required(),
        status: Joi.number().required(),
        actionBy: Joi.string().allow(""),
    });
    return schema.validate(data);
};

module.exports.tripTypeValidation = tripTypeValidation;