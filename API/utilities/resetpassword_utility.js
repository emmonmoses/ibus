const { sendEmail } = require("../utilities/emailer");
const Response = require("../utilities/response_utility");
const ResponseMessage = require("./messages_utility");
const unique = require("../utilities/codegenerator_utility");
const { createActivityLog } = require("../utilities/activitylog_utility");

const resetPassword = async (req, res, model, moduleName) => {
  try {
    const body = req.body;
    var user = await model.findOne({ email: body.email });
    console.log(user);

    if (!user) {
      return Response.customResponse(res, 404, ResponseMessage.NO_RECORD);
    }

    var resetPassword = unique.randomCode();
    var hashedPassword = unique.passwordHash(resetPassword);

    user.password = hashedPassword;

    await user.save();

    const action = `Reset Password - ${user.code}`;
    const userId = `${user._id}`;

    await createActivityLog(moduleName, action, userId);

    var username = "";

    if (user.code.startsWith("CU")) {
      username = user.firstName + " " + user.middleName + " " + user.lastName;
    } else {
      username = user.name;
    }

    const emailSubject = "Reset Password Request".toUpperCase();

    var emailText = `Hi ${username}, <br><br>
    Your password has been reset to <strong>${resetPassword}</strong>. Kindly ensure you change your password after sign in.<br><br>
    Best Regards <br> Dhulkoob Support Team <br><br>
    <a href="http://dhulkoob.com" target="_blank">
    <img src="http://dhulkoob.com/logo.png" alt="Dhulkoob Logo" style="width: 150px; height: auto;">
    </a><br>
    &copy; ${new Date().getFullYear()} All rights reserved.`;

    sendEmail(email, emailSubject, emailText);

    return Response.customResponse(
      res,
      res.statusCode,
      ResponseMessage.EMAIL_SUCCESS
    );
  } catch (error) {
    return Response.errorResponse(res, 500, error);
  }
};

module.exports = { resetPassword };
