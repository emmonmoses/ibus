const Joi = require("joi");
const ResponseMessage = require("../utilities/messages_utility");

const tripValidation = (data) => {
  const schema = Joi.object({
    description: Joi.string().allow(""),
    customers: Joi.array().items(
        Joi.object({
          id: Joi.string().required(),
        })
      ).required(),
    routeId: Joi.string().required(),
    timingId: Joi.string().required(),
    vehicleId: Joi.string().required(),
    tripTypeId: Joi.string().required(),
    status: Joi.boolean(),
    actionBy: Joi.string().allow(""),
  });
  return schema.validate(data);
};

module.exports.tripValidation = tripValidation;
