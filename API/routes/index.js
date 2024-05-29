require("dotenv").config();
const express = require("express");
const router = express.Router();
const version = process.env.API_VERSION;

// version1 Routes
const roleRouter = require("./version1/role");
const userRouter = require("./version1/admin");
const customerRouter = require("./version1/customer");

router.use(`/v${version}/roles`, roleRouter);
router.use(`/v${version}/users`, userRouter);
router.use(`/v${version}/customer`, customerRouter);

module.exports = router;
