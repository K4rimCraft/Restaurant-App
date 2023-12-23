const express = require("express");
const { editRating, editStatus, editNumberOfOrders } = require("../../services/User/deliveryManService");
const { verifyTokenAndAuthorization, verifyTokenDeliveryMan } = require("../../middlewares/verifyToken");

const router = express.Router();

router.put("/editRating", verifyTokenAndAuthorization, editRating);
router.put("/editStatus", verifyTokenDeliveryMan, editStatus);
router.put("/editNumberOfOrders", verifyTokenDeliveryMan, editNumberOfOrders);

module.exports = router;