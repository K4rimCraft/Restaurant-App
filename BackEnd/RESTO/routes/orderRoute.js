const express = require("express");
const { placeOrder, getAllOrders } = require("../services/orderService");
const { verifyTokenDeliveryMan, verifyTokenAndAuthorization } = require("../middlewares/verifyToken");
const router = express.Router();

router.post("/placeOrder", verifyTokenAndAuthorization, placeOrder);
router.get("/getAllOrders", verifyTokenDeliveryMan, getAllOrders);

module.exports = router;