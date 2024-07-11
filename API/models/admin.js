const mongoose = require("mongoose");

const adminSchema = new mongoose.Schema(
  {
    // phone: {
    //   code: {
    //     type: String,
    //   },
    //   number: {
    //     type: Number,
    //   },
    // },
    code: {
      type: String,
    },
    name: {
      type: String,
    },
    email: {
      type: String,
      required: true,
    },
    password: {
      type: String,
    },
    avatar: {
      type: String,
    },
    status: {
      type: Boolean,
      default: false,
    },
    roleId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Role",
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
        delete ret.roleId;
        delete ret._id;
      },
    },
    toJSON: {
      virtuals: true,
      transform: function (doc, ret) {
        delete ret.roleId;
        delete ret._id;
      },
    },
  }
);

// Add a unique compound index for username and name
adminSchema.index({ username: 1, name: 1 }, { unique: true });

adminSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

adminSchema.virtual("role", {
  ref: "Role",
  localField: "roleId",
  foreignField: "_id",
  justOne: true,
});

module.exports = mongoose.model("Administrator", adminSchema);
