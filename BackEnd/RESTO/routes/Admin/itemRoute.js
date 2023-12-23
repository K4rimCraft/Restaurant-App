const express = require("express");

const {
    addItem,
    sendItemPics,
    deleteItem,
    updateItem,
    getItemsWithFilter,
    searchItem, } = require('../../services/Admin/itemService');

const multer = require('multer');
const storage = multer.diskStorage({
    destination: (req, file, cb) => {

        cb(null, './Images')
    },
    filename: (req, file, cb) => {

        cb(null, file.originalname)
    }
})
const upload = multer({ storage: storage })
const router = express.Router();

router.post("/addItem", addItem);
router.post("/sendItemPics", upload.array('file'), sendItemPics);
router.delete('/deleteItem/:itemId', deleteItem)
router.put('/updateItem/:itemId', updateItem)
router.post("/getItemsWithFilter", getItemsWithFilter);
router.post("/searchItem", searchItem);
module.exports = router;