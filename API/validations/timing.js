const Joi = require("joi");

const timingValidation = (data) => {
    const schema = Joi.object({
        name: Joi.string().required(),
        status: Joi.number().required(),
        actionBy: Joi.string().allow(""),
    });
    return schema.validate(data);
};

module.exports.timingValidation = timingValidation;