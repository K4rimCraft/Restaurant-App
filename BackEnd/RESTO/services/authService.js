const asyncHandelr = require("express-async-handler");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const dbConnection = require("../config/database");
const ApiError = require("../utils/apiError");
const { validateCreateUser, validateLogineUser } = require("../models/userModel");


const register = asyncHandelr(async (req, res, next) => {
    const { error } = validateCreateUser(req.body);
    if (error) {
        return next(new ApiError(error.details[0].message, 400));
    }
    const [result1] = await (await dbConnection).query('SELECT * FROM persons where email = ?', [req.body.email]);
    if (result1.length !== 0) {
        return next(new ApiError(`Wrong Email Or Password`, 404));
    }
    const {
        firstName, lastName,
        email, password, birthDate,
        longitudeAddress, latitudeAddress,
        phoneNumber, type } = req.body;
    //const hashedPassword = await bcrypt.hash(password, 10);
    const [result2] = await (await dbConnection).query(`INSERT INTO persons
        (firstName,lastName,email,password,birthDate,longitudeAddress,latitudeAddress,phoneNumber,type)
        VALUES(?,?,?,?,?,?,?,?,?)`,
        [firstName, lastName, email, password, birthDate, longitudeAddress, latitudeAddress, phoneNumber, type]);
    if (type !== "admin") {
        const [result1] = await (await dbConnection).query('SELECT personId FROM persons where email = ?', [req.body.email]);
        const personId = result1[0].personId;
        if (type === "customer") {
            const [result] = await (await dbConnection).query(`INSERT INTO customers (personId) VALUES (?)`, [personId]);
        } else if (type === "deliveryman") {
            const [result] = await (await dbConnection).query(`INSERT INTO deliverymen (personId) VALUES (?)`, [personId]);
        }
    }
    const token = jwt.sign({ id: personId, type: type }, process.env.JWT_SECRETKEY, {
        expiresIn: "90d"
    });
    res.json({ token });
}
);

const login = asyncHandelr(async (req, res, next) => {
    const { error } = validateLogineUser(req.body);
    if (error) {
        return next(new ApiError(error.details[0].message, 400));
    }
    const [result] = await (await dbConnection).query('SELECT * FROM persons where email = ?', [req.body.email]);
    if (result.length === 0) {
        return next(new ApiError(`Wrong Email Or Password`, 404));
    }
    //const passwordMatch  = bcrypt.compare(req.body.password, result[0].password);
    if (req.body.password !== result[0].password) {
        return next(new ApiError(`Wrong Email Or Password`, 404));
    }
    const token = jwt.sign({ id: result[0].personId, type: result[0].type }, process.env.JWT_SECRETKEY, {
        expiresIn: "90d"
    });
    res.json({ token });
}
);

module.exports = {
    register,
    login
};