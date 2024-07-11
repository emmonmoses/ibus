const router = require("express").Router();
const { bearerToken } = require("../../authentication/auth");
const routeController = require("../../controllers/version1/route");

router.use(bearerToken);

router.post("/", routeController.create);
router.get("/", routeController.getAll);
router.get("/:id", routeController.get);
router.patch("/", routeController.update);
router.delete("/:id/:actionBy", routeController.delete);

module.exports = router;