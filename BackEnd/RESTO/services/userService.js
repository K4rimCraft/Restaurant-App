const dbConnection = require("../config/database");
const asyncHandelr = require("express-async-handler");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const ApiError = require("../utils/apiError");
const sendEmail = require("../utils/sendEmail");

async function hashPassword(pass) {
    const saltRounds = 10;
    const hashedPassword = await new Promise((resolve, reject) => {
        bcrypt.hash(pass, saltRounds, function (err, hash) {
            if (err) reject(err)
            resolve(hash)
        });
    })
    return hashedPassword
}

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

const changeForgotPassword = asyncHandelr(async (req, res, next) => {
    const email = req.body.email;
    const hashedPassword = await hashPassword(req.body.password);
    //const hashedPassword = await bcrypt.hash(req.body.password, 10);
    const [result] = await (await dbConnection).query(`UPDATE persons SET password=? WHERE email=?`, [hashedPassword, email]);
    res.status(200).json({ message: "Password Updated" });
});

const forgotPassword = asyncHandelr(async (req, res, next) => {
    const email = req.body.email;
    console.log(req.body.email)
    const [result] = await (await dbConnection).query(`SELECT * FROM persons WHERE email=?`, [email]);
    if (result.length === 0) {
        return next(new ApiError(`Wrong Email`, 404));
    }
    const randomCode = Math.floor(Math.random() * (999999 - 100000 + 1) + 100000);
    // sendEmail(req.body.email, "ResetPassword", randomCode);
    console.log(randomCode);
    res.status(200).json({ message: randomCode });

});

module.exports = {
    getUsers,
    changeEmail,
    changePassword,
    changeForgotPassword,
    forgotPassword
};  