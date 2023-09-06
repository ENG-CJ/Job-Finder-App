const mysql = require('mysql');

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "2234@@KvSql",
    database: "job_finder",
})

db.connect((err)=> {
    if(err){
        console.error('Database connection failed:', err);
        return;
    }
    console.log('Database connected successfully.');
})

module.exports = db;