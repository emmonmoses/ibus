const Joi = require("joi");

const vehicleValidation = (data) => {
  const schema = Joi.object({
    vehicleType: Joi.string().required(),
    vehicleModel: Joi.string().required(),
    vehicleCapacity: Joi.number().required(),
    vehicleRegistration:Joi.string().allow(""),
    status: Joi.bool(),
    actionBy: Joi.string().allow(""),
  });
  return schema.validate(data);
};

module.exports.vehicleValidation = vehicleValidation;
