const mongoose = require("mongoose");

const customerSchema = new mongoose.Schema(
  {
    roleId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Role",
    },
    firstName: {
      type: String,
    },
    middleName: {
      type: String,
    },
    lastName: {
      type: String,
    },
    code: {
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
      state: {
        type: String,
      },
      district: {
        type: String,
      },
      street: {
        type: String,
      },
    },
    status: {
      type: Number,
      default: 1,
    },
    registeredDate: {
      type: Date,
    },
    lastContactedDate: {
      type: Date,
    },
    customerScore: {
      type: Number,
      default: 0,
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

customerSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

customerSchema.virtual("role", {
  ref: "Role",
  localField: "roleId",
  foreignField: "_id",
  justOne: true,
});

module.exports = mongoose.model("Customer", customerSchema);
