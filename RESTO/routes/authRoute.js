const express = require("express");
const {register}=require("../services/authService");

const router = express.Router();

router.post("/register", register);

module.exports = router;