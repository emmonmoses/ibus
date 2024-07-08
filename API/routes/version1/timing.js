const router = require("express").Router();
const { bearerToken } = require("../../authentication/auth");
const timingController = require("../../controllers/version1/timing");

router.use(bearerToken);

router.post("/", timingController.create);
router.get("/", timingController.getAll);
router.get("/:id", timingController.get);
router.patch("/", timingController.update);
router.delete("/:id/:actionBy", timingController.delete);

module.exports = router;