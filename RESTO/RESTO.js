const express = require("express");
const dotenv = require("dotenv");
const morgan = require("morgan");


dotenv.config({ path: "config.env" });
const userRoute = require("./routes/userRoute");
const ApiError = require("./utils/apiError");
const globalError = require("./middlewares/erroeMiddleware");

const RESTO = express();

RESTO.use(express.json());
RESTO.use(express.urlencoded({ extended: true }));
RESTO.use(morgan("dev"));

RESTO.use("/api", userRoute);

RESTO.all("*", (req, res, next) => {
    next(new ApiError(`Can't find this route ${req.originalUrl}`, 400));
});
RESTO.use(globalError);

const PORT = process.env.PORT;
const server = RESTO.listen(PORT, () => {
    console.log(`Hello ${PORT}`);
});

process.on("unhandledRejection", (err) => {
    console.log(`unhandledRejection Errors ${err.name} | ${err.message}`);
    server.close(() => {
        console.log("Shutting down......");
        process.exit(1);
    });
});