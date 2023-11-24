const jwt = require("jsonwebtoken");

const verifyToken = (req, res, next) => {
    const token = req.headers.token;
    if (token) {
        try {
            const decoded = jwt.verify(token, process.env.JWT_SECRETKEY);
            req.person = decoded;
            next();
        } catch {
            res.status(401).json({ message: "Invalid Ioken" });
        }
    } else {
        res.status(401).json({ message: "No Token Provided" });
    }
}

const verifyTokenAndAuthorization = (req, res, next) => {
    verifyToken(req, res, () => {
        if ((req.person.personId == req.params.personId) || (req.person.type === "admin")) {
            next();
        } else {
            return res.status(403).json({ message: "You Are Not Allowed" });
        }
    })
}

const verifyTokenAndAdmin = (req, res, next) => {
    verifyToken(req, res, () => {
        if (req.person.type === "admin") {
            next();
        } else {
            return res.status(403).json({ message: "You Are Not Allowed, Only Admin" });
        }
    })
}

module.exports = {
    verifyTokenAndAuthorization,
    verifyTokenAndAdmin
}