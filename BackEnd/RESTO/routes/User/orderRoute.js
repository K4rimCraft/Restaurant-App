const express = require("express");
const { placeOrder, getAllOrders, getOrdersFilter } = require("../../services/User/orderService");
const { verifyTokenDeliveryMan, verifyTokenAndAuthorization } = require("../../middlewares/verifyToken");
const router = express.Router();

router.post("/placeOrder", verifyTokenAndAuthorization, placeOrder);
router.get("/getAllOrders", verifyTokenDeliveryMan, getAllOrders);
router.get("/getOrdersFilter/:deliveryStatus", verifyTokenAndAuthorization, getOrdersFilter);

module.exports = router;