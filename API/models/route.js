const mongoose = require("mongoose");

const routeSchema = new mongoose.Schema({
    name: {
        type: String,
    },
    status: {
        type: Number,
        default: 1,
    },
    pickupLocationId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Location",
    },
    dropLocationId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Location",
    },
    vehicleTypeId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Vehicle",
    },
    price: {
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
                delete ret.vehicleTypeId;
                delete ret.pickupLocationId;
                delete ret.dropLocationId;
            },
        },
        toJSON: {
            virtuals: true,
            transform: function (doc, ret) {
                delete ret._id;
                delete ret.vehicleTypeId;
                delete ret.pickupLocationId;
                delete ret.dropLocationId;
            },
        },
    },
);

routeSchema.virtual("id").get(function () {
    return this._id.toHexString();
});

routeSchema.virtual("pickupLocation", {
    ref: "Location",
    localField: "pickupLocationId",
    foreignField: "_id",
    justOne: true,
});

routeSchema.virtual("dropLocation", {
    ref: "Location",
    localField: "dropLocationId",
    foreignField: "_id",
    justOne: true,
});

routeSchema.virtual("vehicle", {
    ref: "Vehicle",
    localField: "vehicleTypeId",
    foreignField: "_id",
    justOne: true,
});

module.exports = mongoose.model("Route", routeSchema);