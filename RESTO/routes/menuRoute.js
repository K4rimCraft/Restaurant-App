const express = require("express");
const { getAllItems, getItemByCategory, getMostPopularItems } = require("../services/menuService");
const { verifyTokenAndAuthorization } = require("../middlewares/verifyToken");

const router = express.Router();

router.get("/getAllItems", verifyTokenAndAuthorization, getAllItems);
router.get("/getMostPopularItems", verifyTokenAndAuthorization, getMostPopularItems);
router.get("/getItemByCategory/:name", verifyTokenAndAuthorization, getItemByCategory);

module.exports = router;