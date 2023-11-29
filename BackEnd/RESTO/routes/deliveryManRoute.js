const express = require("express");
const { editRating, editStatus, editNumberOfOrders } = require("../services/deliveryManService");
const { verifyTokenAndAuthorization } = require("../middlewares/verifyToken");

const router = express.Router();

router.put("/editRating", verifyTokenAndAuthorization, editRating);
router.put("/editStatus", verifyTokenAndAuthorization, editStatus);
router.put("/editNumberOfOrders", verifyTokenAndAuthorization, editNumberOfOrders);

module.exports = router;