const express = require("express");

const {
    getOrders,
    getOrdersFilterStatus,
    getOrdersNameFilter,
    getDeliveryMen,
    getDeliveryMenFilterStatus,
    getBookings,
    getBookingWithTableNumberFilter,
    getBookingWithNumberOfPeopleFilter, } = require('../../services/Admin/overviewService');
const router = express.Router();

router.post("/getOrders", getOrders);
router.get("/getOrdersFilterStatus/:deliveryStatus", getOrdersFilterStatus);
router.get("/getOrdersNameFilter/:name", getOrdersNameFilter);

router.get("/getDeliveryMen/:maxNumberOfOrders", getDeliveryMen);
router.get("/getDeliveryMenFilterStatus/:status", getDeliveryMenFilterStatus);
router.get("/getBookings", getBookings);

router.get("/getBookingWithTableNumberFilter/:TableNumber", getBookingWithTableNumberFilter);
router.get("/getBookingWithNumberOfPeopleFilter/:NumberOfPeople", getBookingWithNumberOfPeopleFilter);
module.exports = router;