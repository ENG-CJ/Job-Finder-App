const db = require("../db/db");

module.exports = {
  createUser: (req, res) => {
    const {
      username,
      email,
      password,
      type,
      phone,
      address,
      verified,
      description,
      country,
    } = req.body;
    db.query(
      "INSERT into users (username,email,password,type,mobile,address,verified,description,country) VALUES (?,?,?,?,?,?,?,?,?)",
      [
        username,
        email,
        password,
        type,
        phone,
        address,
        verified,
        description,
        country,
      ],
      (err, data) => {
        if (err) {
          return res.send({
            message: `Registration Failed`,
            description: err.message,
          });
        }
        res.send({ message: "User registered successfully" });
      }
    );
  },

  verifyUser: (req, res) => {
    var sql = "SELECT *from users where email=? and password=?";
    var { email, password } = req.body;
    db.query(sql, [email, password], (err, data) => {
      if (err)
        return res.send({
          message: "there is an error occurred during login",
          errorCode: err.code,
          description: err.message,
        });

      return res.send({
        userData: data,
      });
    });
  },

  fetchUser: (req, res) => {
    var sql = "SELECT *from users where email=?";
    var { email } = req.body;
    db.query(sql, [email], (err, data) => {
      if (err)
        return res.send({
          message: "there is an error occurred during login",
          errorCode: err.code,
          description: err.message,
        });

      return res.send({
        userData: data,
      });
    });
  },
};
