const dbConnection = require("../config/database");
const asyncHandelr = require("express-async-handler");
const ApiError = require("../utils/apiError");

const editRating = asyncHandelr(async (req, res, next) => {
    const { deliveryManId } = req.body;
    const [rows1] = await (await dbConnection).query(`SELECT rating FROM deliveryMen where deliveryManId=? `, [deliveryManId]);
    const rating = parseFloat(rows1[0].rating) + parseFloat(req.body.rating) * 0.01;
    const [rows2] = await (await dbConnection).query(`UPDATE deliveryMen SET rating=? WHERE deliveryManId=?`, [rating, deliveryManId]);
    res.status(200).json(rows2);
});
const editStatus = asyncHandelr(async (req, res, next) => {
    const { deliveryManId, status } = req.body;
    const [rows] = await (await dbConnection).query(`UPDATE deliveryMen SET status=? WHERE deliveryManId=?`, [status, deliveryManId]);
    res.status(200).json(rows);
});

const editNumberOfOrders = asyncHandelr(async (req, res, next) => {
    const { deliveryManId } = req.body;
    const [rows1] = await (await dbConnection).query(`SELECT numberOfOrders FROM deliveryMen where deliveryManId=? `, [deliveryManId]);
    const numberOfOrders = rows1[0].numberOfOrders + 1;
    const [rows2] = await (await dbConnection).query(`UPDATE deliveryMen SET numberOfOrders=? WHERE deliveryManId=?`, [numberOfOrders, deliveryManId]);
    res.status(200).json(rows2);
});
module.exports = {
    editRating,
    editStatus,
    editNumberOfOrders
};