const express = require("express");
const { editRating, editStatus, editNumberOfOrders } = require("../services/deliveryManService");
const { verifyTokenAndAuthorization } = require("../middlewares/verifyToken");

const router = express.Router();

router.post("/editRating", verifyTokenAndAuthorization, editRating);
router.post("/editStatus", verifyTokenAndAuthorization, editStatus);
router.post("/editNumberOfOrders", verifyTokenAndAuthorization, editNumberOfOrders);

module.exports = router;