const express = require("express");
const { getUsers } = require('../services/userService');
const { verifyTokenAndAdmin } = require("../middlewares/verifyToken");

const router = express.Router();

router.get("/", verifyTokenAndAdmin, getUsers);

module.exports = router;