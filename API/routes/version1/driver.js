const router = require("express").Router();
const { bearerToken } = require("../../authentication/auth");
const uploadUtility = require("../../utilities/upload_utility");
const driverController = require("../../controllers/version1/driver");

let destination = `uploads/driver/`;

router.post("/", driverController.create);
router.patch("/forgot/password", driverController.resetPassword);
router.post("/login", driverController.login);

router.use(bearerToken);

router.get("/", driverController.getAll);
router.get("/:id", driverController.get);
router.patch("/", driverController.update);
router.post("/search", driverController.search);
router.delete("/:id/:actionBy", driverController.delete);
router.patch("/change/password", driverController.changePassword);

router.post(
    "/uploadDriverAvatar",
    uploadUtility.uploadDriverAvatar(destination),
    uploadUtility.uploadImage
);

router.post(
    "/uploadDrivingLicense",
    uploadUtility.uploadDriverDocuments(destination),
    uploadUtility.uploadImage
);

router.post(
    "/uploadBusinessLicense",
    uploadUtility.uploadDriverDocuments(destination),
    uploadUtility.uploadImage
);

router.post(
    "/uploadVehicleFront",
    uploadUtility.uploadDriverDocuments(destination),
    uploadUtility.uploadImage
);

router.post(
    "/uploadVehicleBack",
    uploadUtility.uploadDriverDocuments(destination),
    uploadUtility.uploadImage
);

router.post(
    "/uploadVehicleLogBook",
    uploadUtility.uploadDriverDocuments(destination),
    uploadUtility.uploadImage
);

module.exports = router;