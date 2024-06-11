const mongoose = require("mongoose");

const tripTypeSchema = new mongoose.Schema({
    name: {
        type: String,
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

tripTypeSchema.virtual("id").get(function () {
    return this._id.toHexString();
});

module.exports = mongoose.model("TripType", tripTypeSchema);