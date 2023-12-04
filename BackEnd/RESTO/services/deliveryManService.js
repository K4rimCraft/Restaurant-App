const dbConnection = require("../config/database");
const asyncHandelr = require("express-async-handler");
const jwt = require("jsonwebtoken");
const ApiError = require("../utils/apiError");

const editRating = asyncHandelr(async (req, res, next) => {
    const decoded = jwt.verify(req.headers.token, process.env.JWT_SECRETKEY);
    req.person = decoded;
    const [result1] = await (await dbConnection).query(`SELECT personId FROM persons where email=? `, [req.person.email]);
    const personId = result1[0].personId;
    const [result2] = await (await dbConnection).query(`SELECT rating FROM deliveryMen where personId=? `, [personId]);
    const rating = parseFloat(result2[0].rating) + parseFloat(req.body.rating) * 0.01;
    const [result3] = await (await dbConnection).query(`UPDATE deliveryMen SET rating=? WHERE personId=?`, [rating, personId]);
    res.status(200).json(result3);
});

const editStatus = asyncHandelr(async (req, res, next) => {
    const status = req.body.status;
    const decoded = jwt.verify(req.headers.token, process.env.JWT_SECRETKEY);
    req.person = decoded;
    const [result1] = await (await dbConnection).query(`SELECT personId FROM persons where email=? `, [req.person.email]);
    const personId = result1[0].personId;
    const [result2] = await (await dbConnection).query(`UPDATE deliveryMen SET status=? WHERE personId=?`, [status, personId]);
    res.status(200).json(result2);
});

const editNumberOfOrders = asyncHandelr(async (req, res, next) => {
    const decoded = jwt.verify(req.headers.token, process.env.JWT_SECRETKEY);
    req.person = decoded;
    const [result1] = await (await dbConnection).query(`SELECT personId FROM persons where email=? `, [req.person.email]);
    const personId = result1[0].personId;
    const [result2] = await (await dbConnection).query(`SELECT numberOfOrders FROM deliveryMen where personId=? `, [personId]);
    const numberOfOrders = result2[0].numberOfOrders + 1;
    const [result3] = await (await dbConnection).query(`UPDATE deliveryMen SET numberOfOrders=? WHERE personId=?`, [numberOfOrders, personId]);
    res.status(200).json(result3);
});
module.exports = {
    editRating,
    editStatus,
    editNumberOfOrders
};