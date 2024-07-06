const mongoose = require("mongoose");

const tripSubscriptionSchema = new mongoose.Schema(
  {
    tripId: { // extract trip info e.g route,pickupLocation,dropoffLocation,pickupTime
      type: mongoose.Schema.Types.ObjectId,
      ref: "Trip",
    },
    driverId: { // extract driver info e.g name and phone and only
      type: mongoose.Schema.Types.ObjectId,
      ref: "Driver",
    },
    customerId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Customer",
    },
    locationId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Location",
    },
    status: {
      type: Boolean,
      default: true,
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
        delete ret.customerId;
        delete ret.password;
      },
    },
    toJSON: {
      virtuals: true,
      transform: function (doc, ret) {
        delete ret._id;
        delete ret.customerId;
        delete ret.password;
      },
    },
  }
);

tripSubscriptionSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

tripSubscriptionSchema.virtual("role", {
  ref: "Role",
  localField: "customerId",
  foreignField: "_id",
  justOne: true,
});

tripSubscriptionSchema.virtual("vehicle", {
  ref: "Vehicle",
  localField: "driverId",
  foreignField: "_id",
  justOne: true,
});

tripSubscriptionSchema.virtual("location", {
  ref: "Location",
  localField: "locationId",
  foreignField: "_id",
  justOne: true,
});

module.exports = mongoose.model("TripSubscription", tripSubscriptionSchema);
