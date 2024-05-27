const Joi = require("joi");
const ResponseMessage = require("../utilities/messages_utility");

const customerValidation = (data) => {
  const schema = Joi.object({
    roleId: Joi.string().required(),
    firstName: Joi.string().required(),
    middleName: Joi.string().required(),
    lastName: Joi.string().required(),
    email: Joi.string().min(4).required().email(),
    password: Joi.string()
      .min(6)
      .regex(
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]+$/
      )
      .message(ResponseMessage.PASSWORD_VALIDITY)
      .required(),
    phone: Joi.object({
      code: Joi.string(),
      number: Joi.number(),
    }),
    address: Joi.object({
      city: Joi.string().required(),
      country: Joi.string().required(),
      state: Joi.string().allow(""),
      district: Joi.string().allow(""),
      street: Joi.string().allow(""),
      actionBy: Joi.string().allow(""),
    }),
  });
  return schema.validate(data);
};

module.exports.customerValidation = customerValidation;
