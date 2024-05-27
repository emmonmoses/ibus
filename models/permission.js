const mongoose = require("mongoose");

const permissionSchema = new mongoose.Schema(
  {
    menuId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Menu",
    },
    claims: [String],
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
        delete ret.menuId;
      },
    },
    toJSON: {
      virtuals: true,
      transform: function (doc, ret) {
        delete ret._id;
        delete ret.menuId;
      },
    },
  }
);

permissionSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

permissionSchema.virtual("menu", {
  ref: "Menu",
  localField: "menuId",
  foreignField: "_id",
  justOne: true,
});

module.exports = mongoose.model("Permission", permissionSchema);
