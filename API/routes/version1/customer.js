const router = require("express").Router();

const customerController = require("../../controllers/version1/customer");

router.post("/", customerController.create);
router.get("/", customerController.getAll);
router.get("/:id", customerController.get);
router.patch("/", customerController.update);
router.delete("/:id/:userId", customerController.delete);
router.patch("/change/password", customerController.changePassword);
router.patch("/forgot/password", customerController.resetPassword);
router.post("/login", customerController.login);

module.exports = router;