const asyncHandelr = require("express-async-handler");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const dbConnection = require("../config/database");
const ApiError = require("../utils/apiError");
const { validateCreateUser, validateLogineUser } = require("../models/userModel");
const { date } = require("joi");


const register = asyncHandelr(async (req, res, next) => {
    const { error } = validateCreateUser(req.body);
    if (error) {
        return next(new ApiError(error.details[0].message, 400));
    }
    const [rows1] = await (await dbConnection).query('SELECT * FROM persons where personId = ?', [req.body.personId]);
    if (rows1.length !== 0) {
        return next(new ApiError(`Wrong Email Or Password`, 404));
    }
    const {
        personId, firstName, lastName,
        email, password, birthDate,
        longitudeAddress, latitudeAddress,
        phoneNumber, type } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    const [rows2] = await (await dbConnection).query(`INSERT INTO persons VALUES(?,?,?,?,?,?,?,?,?,?)`,
        [personId, firstName, lastName, email, hashedPassword, birthDate, longitudeAddress, latitudeAddress, phoneNumber, type]);
    if (type !== "admin") {
        if (type === "customer") {
            const customerId = req.body.customerId;
            console.log(firstName)
            const [rows] = await (await dbConnection).query(`INSERT INTO customers VALUES (?,?)`, [customerId, personId]);
        } else if (type === "deliveryman") {
            const { deliveryManId } = req.body;
            const [rows] = await (await dbConnection).query(`INSERT INTO deliverymen VALUES (?,0,0,"2023-11-20",0,"not found",?)`, [deliveryManId, personId]);
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
    const [rows] = await (await dbConnection).query('SELECT * FROM persons where email = ?', [req.body.email]);
    if (rows.length === 0) {
        return next(new ApiError(`Wrong Email Or Password`, 404));
    }
    console.log(req.body)
    console.log(rows[0].password)
    const passwordMatch = bcrypt.compare(req.body.password, rows[0].password);
    console.log(passwordMatch)
    if (!passwordMatch) {
        return next(new ApiError(`Wrong Email Or Password`, 404));
    }
    const token = jwt.sign({ id: rows[0].personId, type: rows[0].type }, process.env.JWT_SECRETKEY, {
        expiresIn: "90d"
    });
    res.json({ token });
}
);

module.exports = {
    register,
    login
};