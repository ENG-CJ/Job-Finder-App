const db = require('../db/db');


class User {
    static createUser(username,email,password,type,phone,address,city,country,callback){
        db.query("INSERT into users (username,email,password,type,mobile,address,city,country) VALUES (?,?,?,?,?,?,?,?)",[username,email,password,type,phone,address,city,country], callback)
    }
}


module.exports = User;