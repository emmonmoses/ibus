const mongoose = require("mongoose");

const customerSchema = new mongoose.Schema(
  {
    roleId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Role",
    },
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
        delete ret.routeId;
        delete ret.timingId;
        delete ret.tripTypeId;
        delete ret.password;
      },
    },
    toJSON: {
      virtuals: true,
      transform: function (doc, ret) {
        delete ret._id;
        delete ret.roleId;
        delete ret.routeId;
        delete ret.timingId;
        delete ret.tripTypeId;
        delete ret.password;
      },
    },
  }
);

customerSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

customerSchema.virtual("role", {
  ref: "Role",
  localField: "roleId",
  foreignField: "_id",
  justOne: true,
});

customerSchema.virtual("route", {
  ref: "Route",
  localField: "routeId",
  foreignField: "_id",
  justOne: true,
});

customerSchema.virtual("time", {
  ref: "Timing",
  localField: "timingId",
  foreignField: "_id",
  justOne: true,
});

customerSchema.virtual("tripType", {
  ref: "TripType",
  localField: "tripTypeId",
  foreignField: "_id",
  justOne: true,
});
module.exports = mongoose.model("Customer", customerSchema);
