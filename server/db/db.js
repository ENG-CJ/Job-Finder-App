const mysql = require('mysql');

const db = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "2234@@KvSql",
    database: "job_finder",
})

db.getConnection((err,con)=> {
    if(err){
        console.error('Database connection failed:', err);
        return;
    }
    console.log('Database connected successfully.');
    con.release();
})

module.exports = db;