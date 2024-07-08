const Joi = require("joi");
const ResponseMessage = require("../utilities/messages_utility");

const driverValidation = (data) => {
  const schema = Joi.object({
    roleId: Joi.string().required(),
    vehicleId: Joi.string().required(),
    //locationId: Joi.string().required(),
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
    avatar: Joi.string().required(),
    routeId: Joi.string().required(),
    timingId: Joi.string().required(),
    tripTypeId: Joi.string().required(),
    plateNumber: Joi.string().required(),
    vehicleBack: Joi.string().required(),
    vehicleFront: Joi.string().required(),
    vehicleLogBook: Joi.string().required(),
    drivingLicense: Joi.string().required(),
    plateNumberCode: Joi.string().required(),
    businessLicense: Joi.string().required(),
    isAssigned: Joi.boolean(),
    address: Joi.object({
      city: Joi.string().required(),
      country: Joi.string().required(),
      region: Joi.string().required(""),
    }),
    actionBy: Joi.string().allow(""),
  });
  return schema.validate(data);
};

module.exports.driverValidation = driverValidation;
