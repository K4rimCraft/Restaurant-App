const dbConnection = require("../config/database");
const asyncHandelr = require("express-async-handler");
const ApiError = require("../utils/apiError");

const getUsers = asyncHandelr(async (req, res, next) => {
    const [rows] = await (await dbConnection).query(`SELECT * FROM persons`);
    if (rows.length === 0) {
        return next(new ApiError(`No users Found`, 404));
    }
    res.json(rows);
}
);

module.exports = {
    getUsers,
};  