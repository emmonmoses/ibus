const Joi = require("joi");

const locationValidation = (data) => {
  const schema = Joi.object({
    city: Joi.string().required(),
    subcity: Joi.string().allow(""),
    woreda: Joi.number(),
    status: Joi.bool(),
    actionBy: Joi.string().allow(""),
  });
  return schema.validate(data);
};

module.exports.locationValidation = locationValidation;
