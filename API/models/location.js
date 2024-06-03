const mongoose = require("mongoose");

const locationSchema = new mongoose.Schema(
  {
    city: {
      type: String,
    },
    subcity: {
      type: String,
    },
    woreda: {
      type: Number,
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

locationSchema.virtual("id").get(function () {
  return this._id.toHexString();
});

module.exports = mongoose.model("Location", locationSchema);
