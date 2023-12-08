const dbConnection = require("../config/database");
const asyncHandelr = require("express-async-handler");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const ApiError = require("../utils/apiError");
const sendEmail = require("../utils/sendEmail");

const getUsers = asyncHandelr(async (req, res, next) => {
    const [result] = await (await dbConnection).query(`SELECT * FROM persons`);
    if (rows.length === 0) {
        return next(new ApiError(`No users Found`, 404));
    }
    res.json(rows);
}
);

const changeEmail = asyncHandelr(async (req, res, next) => {
    const decoded = jwt.verify(req.headers.token, process.env.JWT_SECRETKEY);
    req.person = decoded;
    const email = req.body.email;
    const [result] = await (await dbConnection).query(`UPDATE persons SET email=? WHERE personId=?`, [email, req.person.id]);
    res.status(200).json({ message: "Email Updated" });
});

const changePassword = asyncHandelr(async (req, res, next) => {
    const decoded = jwt.verify(req.headers.token, process.env.JWT_SECRETKEY);
    req.person = decoded;
    //const hashedPassword = await bcrypt.hash(req.body.password, 10);
    const [result] = await (await dbConnection).query(`UPDATE persons SET password=? WHERE personId=?`, [req.body.password, req.person.id]);
    res.status(200).json({ message: "Password Updated" });
});

const forgotPassword = asyncHandelr(async (req, res, next) => {
    const email = req.body.email;
    const [result] = await (await dbConnection).query(`SELECT * FROM persons WHERE email=?`, [email]);
    if (result.length === 0) {
        return next(new ApiError(`Wrong Email`, 404));
    }
    sendEmail("mahmoudgalal173.95@gmail.com", "ResetPassword", 5121524);
    const token = jwt.sign({ id: result[0].personId, type: result[0].type }, process.env.JWT_SECRETKEY, {
        expiresIn: "90d"
    });
    res.status(200).json({ token });
});

module.exports = {
    getUsers,
    changeEmail,
    changePassword,
    forgotPassword
};  