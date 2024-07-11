const router = require("express").Router();
const { bearerToken } = require("../../authentication/auth");
const tripController = require("../../controllers/version1/trip");


router.use(bearerToken);

router.get("/:id", tripController.get);
router.post("/", tripController.create);
router.patch("/", tripController.update);
router.get("/", tripController.getTrips);
router.delete("/:id/:actionBy", tripController.delete);
router.get("/driver/:id", tripController.getTripsByDriver);
router.get("/customer/:id", tripController.getTripsByCustomer);

module.exports = router;
