const express = require("express");

const { addCategory, getCategories, deleteCategory } = require('../../services/Admin/categoryService');
const router = express.Router();

router.post("/addCategory", addCategory);
router.get("/getCategories", getCategories);
router.delete("/deleteCategory/:categoryId", deleteCategory);
module.exports = router;