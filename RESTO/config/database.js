const mysql = require('mysql2/promise');

const dbConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'resto'
});

module.exports = dbConnection;