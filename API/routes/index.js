require("dotenv").config();
const express = require("express");
const router = express.Router();
const version = process.env.API_VERSION;

// version1 Routes
const roleRouter = require("./version1/role");
const userRouter = require("./version1/admin");

router.use(`/v${version}/roles`, roleRouter);
router.use(`/v${version}/users`, userRouter);

module.exports = router;
