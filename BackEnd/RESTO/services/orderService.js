const dbConnection = require("../config/database");
const asyncHandelr = require("express-async-handler");
const jwt = require("jsonwebtoken");
const ApiError = require("../utils/apiError");

const placeOrder = asyncHandelr(async (req, res, next) => {
    const { longitudeAddress, latitudeAddress, itemsList } = req.body;
    var totalPrice = 0;
    var items = [];
    for (var i = 0; i < itemsList.length; i++) {
        items[i] = itemsList[i].itemId;
    }
    const [result1] = await (await dbConnection).query(`SELECT itemId,price FROM menuitems WHERE itemId IN (?)`, [items]);
    for (var i = 0; i < itemsList.length; i++) {
        for (var j = 0; j < result1.length; j++) {
            if (result1[j].itemId === itemsList[i].itemId) {
                totalPrice += result1[j].price * itemsList[i].quantity;
            }
        }
    }
    const decoded = jwt.verify(req.headers.token, process.env.JWT_SECRETKEY);
    req.person = decoded;
    const [result2] = await (await dbConnection).query(`SELECT customerId FROM customers WHERE personId=(SELECT personId FROM persons WHERE email=?)`, [req.person.email]);
    const [result3] = await (await dbConnection).query(`INSERT INTO orders (longitudeAddress,latitudeAddress,customerId,totalPrice) VALUES (?,?,?,?)`, [longitudeAddress, latitudeAddress, result2[0].customerId, totalPrice]);
    const [result4] = await (await dbConnection).query(`SELECT MAX(orderId) AS orderId FROM orders`);
    for (var i = 0; i < itemsList.length; i++) {
        const [result] = await (await dbConnection).query(`INSERT INTO orders_has_menuitems VALUES (?,?,?)`, [result4[0].orderId, itemsList[i].itemId, itemsList[i].quantity]);
    }
    res.status(201).json({ totalPrice: totalPrice + "$" });
});

const getAllOrders = asyncHandelr(async (req, res, next) => {
    const [result] = await (await dbConnection).query(`SELECT * FROM orders`);
    if (result.length == 0) {
        return next(new ApiError(`No Orders Found`, 404));
    }
    res.status(200).json(result);
});
module.exports = {
    placeOrder,
    getAllOrders
}