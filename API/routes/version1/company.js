const router = require("express").Router();
const { bearerToken } = require("../../authentication/auth");

const companyController = require("../../controllers/version1/company");

router.patch("/forgot/password", companyController.resetPassword);
router.post("/login", companyController.login);

router.use(bearerToken);

router.post("/", companyController.create);
router.get("/", companyController.getAll);
router.get("/:id", companyController.get);
router.patch("/", companyController.update);
router.delete("/:id/:userId", companyController.delete);
router.patch("/change/password", companyController.changePassword);

module.exports = router;