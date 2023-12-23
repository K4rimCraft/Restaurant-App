const dbConnection = require("../../config/database");
const asyncHandelr = require("express-async-handler");
const ApiError = require("../../utils/apiError");
const jwt = require("jsonwebtoken");

const addBooking = asyncHandelr(async (req, res, next) => {
    const { numOfPeople, tableNumber, date, startTime, endTime } = req.body;
    if (startTime < '08:00' || endTime < '08:00') {
        return next(new ApiError("Resto is open from 8:00 Am to 12:00 Am!", 400));
    }
    if (startTime > endTime) {
        return next(new ApiError("The time entered is incorrect!", 400));
    }
    var sql2 = (`SELECT tableNumber,startTime,endTime FROM bookings WHERE date='${date}' And tableNumber=${tableNumber} And startTime < '${endTime}' And  endTime > '${startTime}' order by startTime;`)
    const [conflictingBookings] = await (await dbConnection).query(sql2);

    if (conflictingBookings.length === 0) {
        const decoded = jwt.verify(req.headers.token, process.env.JWT_SECRETKEY);
        req.person = decoded;
        const [result] = await (await dbConnection).query(`SELECT customerId FROM customers where personId=? `, [req.person.id]);
        const customerId = result[0].customerId;
        var sql = 'INSERT INTO bookings (numberOfPeople,tableNumber,date,startTime,endTime,customerId) VALUES (?,?,?,?,?,?);'
        var Values = [numOfPeople, tableNumber, date, startTime, endTime, customerId];
        await (await dbConnection).query(sql, Values);
        res.status(200).send({ message: 'Data received successfully!' });
    } else {
        res.status(400).json(conflictingBookings);
    }
});

const getByDate = asyncHandelr(async (req, res) => {
    const date = req.body.date;
    var sql = (`SELECT tableNumber,startTime,endTime FROM bookings WHERE date='${date}'order by startTime;`);
    const [bookings] = await (await dbConnection).query(sql)
    res.status(200).json(bookings)
});

const getAllBooking = asyncHandelr(async (req, res) => {
    var sql = (`SELECT * FROM bookings ORDER BY date,startTime;`);
    const [bookings] = await (await dbConnection).query(sql)
    res.status(200).json(bookings)
});

const getBusyTables = asyncHandelr(async (req, res) => {
    const { date, startTime, endTime } = req.body;
    var sql = (`SELECT tableNumber FROM bookings WHERE date='${date}' And startTime < '${endTime}' And  endTime > '${startTime}' order by startTime;`);
    const [busyTables] = await (await dbConnection).query(sql)
    // var numbers = []
    // for( i = 0; i <busyTables.length; i++ ){
    //     numbers.
    // }
    res.status(200).send(busyTables)
});

const deleteBooking = asyncHandelr(async (req, res, next) => {
    const { date, startTime, tableNumber } = req.body;
    const decoded = jwt.verify(req.headers.token, process.env.JWT_SECRETKEY);
    req.person = decoded;
    const [result] = await (await dbConnection).query(`SELECT customerId FROM customers where personId=? `, [req.person.id]);
    const customerId = result[0].customerId;
    var sql = (`DELETE from bookings WHERE customerId=${customerId} AND startTime='${startTime}' AND date ='${date}' AND tableNumber=${tableNumber};`)
    const [bookings] = await (await dbConnection).query(sql)
    if (bookings.affectedRows === 0) {
        return ApiError("there is no bookings with the entered details", 404);
    }
    else {
        res.status(200).json({ DeletedRows: bookings.affectedRows })
    }
});

module.exports = {
    addBooking,
    getByDate,
    getAllBooking,
    getBusyTables,
    deleteBooking
}