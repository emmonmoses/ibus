require("dotenv").config();
const express = require("express");
const router = express.Router();
const version = process.env.API_VERSION;

// version1 Routes
const userRouter = require("./version1/admin");

router.use(`/v${version}/users`, userRouter);

module.exports = router;
