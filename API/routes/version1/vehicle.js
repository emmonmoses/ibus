const router = require("express").Router();
const { bearerToken } = require("../../authentication/auth");
const vehicleController = require("../../controllers/version1/vehicle");

router.use(bearerToken);

router.get("/:id", vehicleController.get);
router.post("/", vehicleController.create);
router.patch("/", vehicleController.update);
router.get("/", vehicleController.getVehicles);
router.delete("/:id/:actionBy", vehicleController.delete);
router.get("/city/:city", vehicleController.searchVehicles);

module.exports = router;
