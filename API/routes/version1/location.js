const router = require("express").Router();
const { bearerToken } = require("../../authentication/auth");
const locationController = require("../../controllers/version1/location");

router.use(bearerToken);

router.get("/:id", locationController.get);
router.post("/", locationController.create);
router.patch("/", locationController.update);
router.get("/", locationController.getLocations);
router.delete("/:id/:actionBy", locationController.delete);
router.get("/city/:city", locationController.getLocationsByCity);

module.exports = router;
