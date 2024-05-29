require("dotenv").config();
const express = require("express");
const router = express.Router();
const version = process.env.API_VERSION;

// version1 Routes
const userRouter = require("./version1/admin");
const customerRouter = require("./version1/customer");

router.use(`/v${version}/users`, userRouter);
router.use(`/v${version}/customer`, customerRouter);

module.exports = router;
