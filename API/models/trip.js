const mongoose = require("mongoose");

const tripSchema = new mongoose.Schema(
  {
    code: {
      type: String,
    },
    description: {
      type: String,
    },
    customers: [
      {
        id: {
          type: mongoose.Schema.Types.ObjectId,
          ref: "Customer",
        },
        _id: false,
      },
    ],
    routeId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Route",
    },
    timingId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Timing",
    },
    vehicleId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Vehicle",
    },
    tripTypeId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "TripType",
    },
    driverId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Driver",
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
      immutable: true,
    },
  },
  {
    versionKey: false,
    toObject: {
      virtuals: true,
      transform: function (doc, ret) {
        delete ret._id;
        delete ret.routeId;
        delete ret.timingId;
        delete ret.vehicleId;
        delete ret.tripTypeId;
      },
    },
    toJSON: {
      virtuals: true,
      transform: function (doc, ret) {
        delete ret._id;
        delete ret.routeId;
        delete ret.timingId;
        delete ret.vehicleId;
        delete ret.tripTypeId;
      },
    },
  }
);

tripSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

tripSchema.virtual("route", {
  ref: "Route",
  localField: "routeId",
  foreignField: "_id",
  justOne: true,
});

tripSchema.virtual("vehicle", {
  ref: "Vehicle",
  localField: "vehicleId",
  foreignField: "_id",
  justOne: true,
});

tripSchema.virtual("tripType", {
  ref: "TripType",
  localField: "tripTypeId",
  foreignField: "_id",
  justOne: true,
});

tripSchema.virtual("timing", {
  ref: "Timing",
  localField: "timingId",
  foreignField: "_id",
  justOne: true,
});

tripSchema.virtual("location", {
  ref: "Location",
  localField: "locationId",
  foreignField: "_id",
  justOne: true,
});

module.exports = mongoose.model("Trip", tripSchema);
