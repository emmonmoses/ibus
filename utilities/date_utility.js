const moment = require("moment-timezone");
require("moment");

module.exports = {
  currentDate: () => moment().tz("Africa/Nairobi").toDate(),
  validFromDate: () => moment().tz("Africa/Nairobi"),
  expirationDate: () => moment().tz("Africa/Nairobi").add(4, "hours"),
};
