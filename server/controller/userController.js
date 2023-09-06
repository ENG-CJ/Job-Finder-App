const e = require("express");
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

  updateUser: (req, res) => {
    const {
      id,
      username,
      email,
      mobile,
      address,
      verified,
      description,
      country,
    } = req.body;

    const updateFields = [];
    const updateValues = [];

    const fieldToUpdate = {
      username,
      email,
      mobile,
      address,
      verified,
      description,
      country,
    };

    for (const field in fieldToUpdate) {
      if (fieldToUpdate[field] !== undefined) {
        updateFields.push(`${field} = ?`);
        updateValues.push(fieldToUpdate[field]);
      }
    }

    if (updateFields.length === 0) {
      return res.status[400].json({ message: "No fields to update" });
    }

    const updateUserQuery = `Update users SET ${updateFields.join(
      ", "
    )} where id = ?`;
    updateValues.push(id);

    db.query(updateUserQuery, updateValues, (err, result) => {
      if (err) {
        return res
          .status(500)
          .json({ message: `Update Failed`, description: err.message });
      }

      if (result.effectedRow === 0) {
        return res
          .status(404)
          .json({
            message: `User with ID ${id} not found`,
            description: err.message,
          });
      }

      return res.status(200).json({ message: "User Updated Successfully" });
    });
  },
};
