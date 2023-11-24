const express = require("express");
const { getUsers } = require('../services/userService');

const router = express.Router();

router.get("/", getUsers);

module.exports = router;