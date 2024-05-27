const Joi = require("joi");

const permissionValidation = (data) => {
  const schema = Joi.object({
    menuId: Joi.string().required(),
    claims: Joi.array().required(),
  });
  return schema.validate(data);
};

module.exports.permissionValidation = permissionValidation;
