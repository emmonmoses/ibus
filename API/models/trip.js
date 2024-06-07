const mongoose = require("mongoose");

const tripSchema = new mongoose.Schema(
  {
    pickUp: {
      type: String,
    },
    dropOff: {
      type: String,
    },
    vehicleId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Vehicle",
    },
    locationId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Location",
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
      },
    },
    toJSON: {
      virtuals: true,
      transform: function (doc, ret) {
        delete ret._id;
        delete ret.roleId;
        delete ret.password;
      },
    },
  }
);

tripSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

tripSchema.virtual("role", {
  ref: "Role",
  localField: "roleId",
  foreignField: "_id",
  justOne: true,
});

tripSchema.virtual("vehicle", {
  ref: "Vehicle",
  localField: "vehicleId",
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
