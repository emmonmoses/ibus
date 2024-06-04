const mongoose = require("mongoose");

const companySchema = new mongoose.Schema({
    roleId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Role",
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
    },
);

companySchema.virtual("id").get(function () {
    return this._id.toHexString();
});

companySchema.virtual("role", {
    ref: "Role",
    localField: "roleId",
    foreignField: "_id",
    justOne: true,
});

module.exports = mongoose.model("Company", companySchema);