const router = require("express").Router();
const { bearerToken } = require("../../authentication/auth");
const driverController = require("../../controllers/version1/driver");

router.post("/", driverController.create);
router.patch("/forgot/password", driverController.resetPassword);
router.post("/login", driverController.login);

router.use(bearerToken);

router.get("/", driverController.getAll);
router.get("/:id", driverController.get);
router.patch("/", driverController.update);
router.delete("/:id/:actionBy", driverController.delete);
router.patch("/change/password", driverController.changePassword);

module.exports = router;