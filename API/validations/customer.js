const Joi = require("joi");
const ResponseMessage = require("../utilities/messages_utility");

const customerValidation = (data) => {
  const schema = Joi.object({
    roleId: Joi.string().required(),
    routeId: Joi.string().required(),
    timingId: Joi.string().required(),
    tripTypeId: Joi.string().required(),
    name: Joi.string().required(),
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
      region: Joi.string().required(""),
    }),
  });
  return schema.validate(data);
};

module.exports.customerValidation = customerValidation;
