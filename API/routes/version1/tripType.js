const router = require("express").Router();
const { bearerToken } = require("../../authentication/auth");
const tripTypeController = require("../../controllers/version1/tripType");

router.use(bearerToken);

router.post("/", tripTypeController.create);
router.get("/", tripTypeController.getAll);
router.get("/:id", tripTypeController.get);
router.patch("/", tripTypeController.update);
router.delete("/:id/:actionBy", tripTypeController.delete);

module.exports = router;