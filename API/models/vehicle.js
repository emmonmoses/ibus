const mongoose = require("mongoose");

const vehicleSchema = new mongoose.Schema(
  {
    vehicleType: {
      type: String,
    },
    vehicleModel: {
      type: String,
    },
    vehicleCapacity: {
      type: Number,
    },
    vehicleRegistration: {
      type: String,
    },
    status: {
      type: Boolean,
      default: false,
    },
    createdAt: {
      type: Date,
      immutable: true,
    },
    updatedAt: {
      type: Date,
    },
  },
  {
    versionKey: false,
    toObject: {
      virtuals: true,
      transform: function (doc, ret) {
        delete ret._id;
      },
    },
    toJSON: {
      virtuals: true,
      transform: function (doc, ret) {
        delete ret._id;
      },
    },
  }
);

vehicleSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

module.exports = mongoose.model("Vehicle", vehicleSchema);
