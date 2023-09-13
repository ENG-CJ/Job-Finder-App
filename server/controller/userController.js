const e = require("express");
const db = require("../db/db");
const fs = require("fs");


module.exports = {
  createUser: (req, res) => {
    const {
      username,
      email,
      password,
      type,
      mobile,
      address,
      verified,
      description,
      country,
    } = req.body;

    const profile_pic = req.file;

    db.query(
      "INSERT into users (username,email,password,type,mobile,address,verified,description,country,profile_pic) VALUES (?,?,?,?,?,?,?,?,?,?)",
      [
        username,
        email,
        password,
        type,
        mobile,
        address,
        verified,
        description,
        country,
        req.file ? req.file.filename : "null",
      ],
      (err, data) => {
        if (err) {
          return res.status(500).send({
            message: `Registration Failed`,
            description: err.message,
          });
        }
        res.send({ message: "User registered successfully " });
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
    var sql = "SELECT *from users where id=?";
    var { id } = req.body;
    db.query(sql, [id], (err, data) => {
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
      description,
      country,
      oldImage,
    } = req.body;
    var query =
      "UPDATE users set username=?, email=?, mobile=?,description=?,country=?, profile_pic=? where id=? ";
    db.query(
      query,
      [
        username,
        email,
        mobile,
        description,
        country,
         req.file ? req.file.filename : oldImage,
        id,
      ],
      (err, result) => {
        if (err) {
          return res
            .status(500)
            .json({ message: `Update Failed`, description: err.message });
        }

        return res.send({
          file: req.file ? req.file : "false",

          old: oldImage,
          message: "Your Profile Has been updated successfully",
        });
      }
    );
  },

  deleteImage: (req, res, next) => {
    if (req.file) {
        if (fs.existsSync(`./public/uploads/${req.body.oldImage}`)) {
          fs.unlink(`./public/uploads/${req.body.oldImage}`, (err) => {
            if (err)
              return res.status(500).send({
                message: "Updated Process failed please try again",
                description: err.message,
              });

            next();
          });
        } else {
        
          next();
        }
    
      }else next();
     
  },
  
};
