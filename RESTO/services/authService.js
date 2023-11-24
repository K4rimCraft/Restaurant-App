const asyncHandelr = require("express-async-handler");
const jwt = require("jsonwebtoken");
const dbConnection = require("../config/database");
const ApiError = require("../utils/apiError");


const register = asyncHandelr(async (req, res, next) => {
    const [rows1] = await (await dbConnection).query('SELECT * FROM persons where personId = ?', [req.body.personId]);
    if (rows1.length !== 0) {
        return next(new ApiError(`Wrong Email Or Password`, 404));
    }
    const {
        personId, firstName, lastName,
        email, password, birthDate,
        longitudeAddress, latitudeAddress,
        phoneNumber, type } = req.body;
    const [rows2] = await (await dbConnection).query(`INSERT INTO persons VALUES(?,?,?,?,?,?,?,?,?,?)`,
        [personId, firstName, lastName, email, password, birthDate, longitudeAddress, latitudeAddress, phoneNumber, type]);
    const token = jwt.sign({ id: personId, type: type }, process.env.JWT_SECRETKEY, {
        expiresIn: "90d"
    });
    res.json({ token });
}
);

module.exports = {
    register
};