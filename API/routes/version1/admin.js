const router = require("express").Router();
const { bearerToken } = require("../../authentication/auth");
const uploadUtility = require("../../utilities/upload_utility");
const userController = require("../../controllers/version1/systemUser");

let destination = `uploads/systemusers/`;

router.post("/login", userController.login);
router.patch("/forgot/password", userController.resetPassword);
router.get("/image/:code/:avatar", uploadUtility.getImage(destination));
router.post("/", userController.create);

router.use(bearerToken);

router.get("/:id", userController.get);
router.get("/", userController.getUsers);
router.patch("/", userController.update);
router.delete("/:id/:userId", userController.delete);
router.get("/role/:id", userController.getUsersByRole);
router.patch("/change/password", userController.changePassword);

router.post(
  "/upload/:code",
  uploadUtility.uploadAvatar(destination),
  uploadUtility.uploadImage
);

module.exports = router;
