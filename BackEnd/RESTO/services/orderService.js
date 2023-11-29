const dbConnection = require("../config/database");
const asyncHandelr = require("express-async-handler");
const nodemailer = require('nodemailer');
const ApiError = require("../utils/apiError");

const placeOrder = asyncHandelr(async (req, res, next) => {
    const { customerId, longitudeAddress, latitudeAddress, itemsList } = req.body;
    var totalPrice = 0;
    var items = [];
    for (var i = 0; i < itemsList.length; i++) {
        items[i] = itemsList[i].itemId;
    }
    console.log(JSON.stringify(itemsList))
    const [rows1] = await (await dbConnection).query(`SELECT itemId,price FROM menuitems WHERE itemId IN (?)`, [items]);
    for (var i = 0; i < items.length; i++) {
        for (var j = 0; j < rows1.length; j++) {
            if (rows1[j].itemId === items[i]) {
                totalPrice += rows1[j].price;
            }
        }
    }
    const [rows2] = await (await dbConnection).query(`INSERT INTO orders (orderId,longitudeAddress,latitudeAddress,customerId,itemsList,totalPrice) VALUES (?,?,?,?,?,?)`, [3, longitudeAddress, latitudeAddress, customerId, JSON.stringify(itemsList), totalPrice]);
    const [rows3] = await (await dbConnection).query(`SELECT email FROM persons WHERE personId = (SELECT personId FROM customers WHERE customerId = ?)`, [customerId]);
    const transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
            user: "mg8846903@gmail.com",
            pass: "bpxfalwtnqildldt"
        }
    });
    const mailOption = {
        from: "mg8846903@gmail.com",
        to: /*rows3[0].email*/"mahmoudgalal173.95@gmail.com",
        subject: "الفاتوره",
        html: `
        <div>
            <h1>totalprice : ${totalPrice}$</h1>
        </div>`
    };
    transporter.sendMail(mailOption, (error, success) => {
        if (error) {
            console.log(error);
        } else {
            console.log("Email sent : " + success.response);
        }
    });
    res.status(201).json({ totalPrice: totalPrice + "$" });
});

const getAllOrders=asyncHandelr(async(req,res,next)=>{
    const [rows]= await(await dbConnection).query(`SELECT * FROM orders`);
    if(rows.length==0){
        return  next(new ApiError(`No Orders Found`, 404));
    }
    res.status(200).json(rows);
});
module.exports = {
    placeOrder,
    getAllOrders
}