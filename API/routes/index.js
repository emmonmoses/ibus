require("dotenv").config();
const express = require("express");
const router = express.Router();
const version = process.env.API_VERSION;

// version1 Routes
const roleRouter = require("./version1/role");
const userRouter = require("./version1/admin");
const driverRouter = require("./version1/driver");
const vehicleRouter = require("./version1/vehicle");
const customerRouter = require("./version1/customer");
const locationRouter = require("./version1/location");
const companyRouter = require("./version1/company");
const tripTypeRouter = require("./version1/tripType");
const timingRouter = require("./version1/timing");
const routeRouter = require("./version1/route");

router.use(`/v${version}/roles`, roleRouter);
router.use(`/v${version}/users`, userRouter);
router.use(`/v${version}/drivers`, driverRouter);
router.use(`/v${version}/vehicles`, vehicleRouter);
router.use(`/v${version}/customer`, customerRouter);
router.use(`/v${version}/locations`, locationRouter);
router.use(`/v${version}/company`, companyRouter);
router.use(`/v${version}/tripType`, tripTypeRouter);
router.use(`/v${version}/timing`, timingRouter);
router.use(`/v${version}/route`, routeRouter);

module.exports = router;
