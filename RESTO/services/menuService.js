const dbConnection = require("../config/database");
const asyncHandelr = require("express-async-handler");
const ApiError = require("../utils/apiError");

const getAllItems = asyncHandelr(async (req, res, next) => {
    const [rows] = await (await dbConnection).query("SELECT * FROM menuItems");
    if (rows.length === 0) {
        return next(new ApiError(`No Items Found`, 404));
    }
    res.status(200).json(rows);
});

const getItemByCategory = asyncHandelr(async (req, res, next) => {
    const [rows1] = await (await dbConnection).query("SELECT categoryId FROM categories where categoryName=?", [req.params.name]);
    if (rows1.length === 0) {
        return next(new ApiError(`No Items Found`, 404));
    }
    const categoryId = rows1[0].categoryId;
    const [rows2] = await (await dbConnection).query(`SELECT
    menuitems.itemId,menuitems.name,menuitems.inStock,menuitems.description,menuitems.rating,menuitems.price,menuitems.timesOrdered,menuitems.image
    FROM menuitems INNER JOIN categories_has_menuitems
    ON categories_has_menuitems.itemId=menuitems.itemId AND categories_has_menuitems.categoyId=?`, [categoryId]);
    if (rows2.length === 0) {
        return next(new ApiError(`No Items Found`, 404));
    }
    res.status(200).json(rows2);
});

const getMostPopularItems = asyncHandelr(async (req, res, next) => {
    const [rows] = await (await dbConnection).query("SELECT * FROM menuItems WHERE rating > 3.5 OR timesOrdered >100 ORDER BY rating DESC");
    if (rows.length === 0) {
        return next(new ApiError(`No Items Found`, 404));
    }
    res.status(200).json(rows);
});

module.exports = {
    getAllItems,
    getItemByCategory,
    getMostPopularItems
};