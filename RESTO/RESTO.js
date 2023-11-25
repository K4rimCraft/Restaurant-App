const express = require("express");
const dotenv = require("dotenv");
const logger = require("./middlewares/logger");


dotenv.config({ path: "config.env" });
process.env.TZ = process.env.TIMEZONE;
const userRoute = require("./routes/userRoute");
const authRoute = require("./routes/authRoute");
const ApiError = require("./utils/apiError");
const globalError = require("./middlewares/erroeMiddleware");

const RESTO = express();

RESTO.use(express.json());
RESTO.use(express.urlencoded({ extended: true }));
RESTO.use(logger);

RESTO.use("/api", userRoute);
RESTO.use("/api", authRoute);

RESTO.all("*", (req, res, next) => {
    next(new ApiError(`Can't find this route ${req.originalUrl}`, 400));
});
RESTO.use(globalError);

const PORT = process.env.PORT;
const server = RESTO.listen(PORT, () => {
    console.log(`Server start in port ${PORT}`);
});

process.on("unhandledRejection", (err) => {
    console.log(`unhandledRejection Errors ${err.name} | ${err.message}`);
    server.close(() => {
        console.log("Shutting down......");
        process.exit(1);
    });
});