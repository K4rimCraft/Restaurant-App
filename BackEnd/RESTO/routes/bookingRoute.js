const express = require("express");
const { addBooking, getAllBooking, getByDate, getBusyTables, deleteBooking } = require("../services/bookingService");
const { verifyTokenAndAuthorization } = require("../middlewares/verifyToken");

const router = express.Router();

router.post("/addBooking", verifyTokenAndAuthorization, addBooking);
router.post("/getByDate", verifyTokenAndAuthorization, getByDate);
router.get("/getAllBooking", verifyTokenAndAuthorization, getAllBooking);
router.get("/getBusyTables", verifyTokenAndAuthorization, getBusyTables);
router.delete("/deleteBooking", verifyTokenAndAuthorization, deleteBooking);

module.exports = router;