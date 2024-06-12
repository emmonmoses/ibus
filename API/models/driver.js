const mongoose = require("mongoose");

const driverSchema = new mongoose.Schema(
  {
    roleId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Role",
    },
    vehicleId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Vehicle",
    },
    // locationId: {
    //   type: mongoose.Schema.Types.ObjectId,
    //   ref: "Location",
    // },
    routeId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Route",
    },
    timingId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Timing",
    },
    tripTypeId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "TripType",
    },
    avatar: {
      type: String,
    },
    drivingLicense: {
      type: String,
    },
    plateNumber: {
      type: String,
    },
    plateNumberCode: {
      type: String,
    },
    businessLicense: {
      type: String,
    },
    isAssigned: {
      type: Boolean,
    },
    code: {
      type: String,
    },
    name: {
      type: String,
    },
    email: {
      type: String,
    },
    password: {
      type: String,
    },
    phone: {
      code: {
        type: String,
      },
      number: {
        type: Number,
      },
    },
    address: {
      city: {
        type: String,
      },
      country: {
        type: String,
      },
      region: {
        type: String,
      },
    },
    status: {
      type: Number,
      default: 1,
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
        delete ret.roleId;
        delete ret.password;
        delete ret.routeId;
        delete ret.timingId;
        delete ret.tripTypeId;
        delete ret.vehicleId;
      },
    },
    toJSON: {
      virtuals: true,
      transform: function (doc, ret) {
        delete ret._id;
        delete ret.roleId;
        delete ret.password;
        delete ret.routeId;
        delete ret.timingId;
        delete ret.tripTypeId;
        delete ret.vehicleId;
      },
    },
  }
);

driverSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

driverSchema.virtual("role", {
  ref: "Role",
  localField: "roleId",
  foreignField: "_id",
  justOne: true,
});

driverSchema.virtual("vehicle", {
  ref: "Vehicle",
  localField: "vehicleId",
  foreignField: "_id",
  justOne: true,
});

// driverSchema.virtual("location", {
//   ref: "Location",
//   localField: "locationId",
//   foreignField: "_id",
//   justOne: true,
// });

driverSchema.virtual("route", {
  ref: "Route",
  localField: "routeId",
  foreignField: "_id",
  justOne: true,
});

driverSchema.virtual("timing", {
  ref: "Timing",
  localField: "timingId",
  foreignField: "_id",
  justOne: true,
});

driverSchema.virtual("tripType", {
  ref: "TripType",
  localField: "tripTypeId",
  foreignField: "_id",
  justOne: true,
});

module.exports = mongoose.model("Driver", driverSchema);
