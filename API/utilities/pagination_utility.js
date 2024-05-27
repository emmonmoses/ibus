const Pagination = require("../models/pagination");

module.exports = {
  paginationParams: async (req, totalItems, defaultPageSize = 10) => {
    const pagination = new Pagination({});

    pagination.page = parseInt(req.query.page) || 1;
    pagination.pageSize = parseInt(req.query.pageSize) || defaultPageSize;
    pagination.rows = totalItems;
    pagination.pages = Math.ceil(totalItems / pagination.pageSize);
    const skip = (pagination.page - 1) * pagination.pageSize;

    return { pagination, skip };
  },
};
