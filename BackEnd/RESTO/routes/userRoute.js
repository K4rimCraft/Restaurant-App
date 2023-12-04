const express = require("express");
const { getUsers, changeEmail, changePassword, forgotPassword } = require('../services/userService');
const { verifyTokenAndAdmin, verifyTokenAndAuthorization } = require("../middlewares/verifyToken");

const router = express.Router();

router.get("/getUsers", verifyTokenAndAdmin, getUsers);
router.put("/changeEmail", verifyTokenAndAuthorization, changeEmail);
router.put("/changePassword", verifyTokenAndAuthorization, changePassword);
router.post("/forgotPassword",  forgotPassword);

module.exports = router;