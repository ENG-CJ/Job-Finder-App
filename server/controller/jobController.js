const db = require("../db/db");
const cr = require("crypto");

module.exports = {
  createJob: (req, res) => {
    const {
      jobTitle,
      jobType,
      description,
      deadLine,
      active,
      applicants,
      owner,
      qualifyAsList,
    } = req.body;
    var sql = "CALL createJob(?,?,?,?,?,?,?,?,?)";
    db.query(
      sql,
      [
        cr.randomUUID(),
        jobTitle,
        jobType,
        description,
        deadLine,
        active,
        applicants,
        owner,
        qualifyAsList,
      ],
      (err, data) => {
        if (err) {
          return res.send({
            message: `Registration Failed`,
            description: err.message,
          });
        }
        res.send({ message: "Job Has been created successfully" });
      }
    );
  },

  fetchJob: (req, res) => {
    var sql = "CALL fetchJob(?)";
    var { id } = req.params;
    db.query(sql, [id], (err, data) => {
      if (err)
        return res.send({
          message: "there is an error occurred during login",
          errorCode: err.code,
          description: err.message,
        });

      return res.send({
        "the id ": id,
        jobs: data,
      });
    });
  },

  deleteJob: (req, res) => {
    var sql = "DELETE from jobs where id=?";
    var { id } = req.params;
    db.query(sql, [id], (err, data) => {
      if (err)
        return res.send({
          message: "there is an error occurred during login",
          errorCode: err.code,
          description: err.message,
        });

      return res.send({
        message: "the record has been successfully deleted",
      });
    });
  },

  updateJob: (req, res) => {
    const {
      id,
      jobTitle,
      jobType,
      jobDescription,
      qualifyAsList,
      active,
      deadLine,
   
    } = req.body;
    
    var query =
      "UPDATE jobs SET jobTitle=?, jobType=?, descripton=?, qualifications=?, active=?, deadLine=? WHERE id = ?";
    db.query(
      query,
      [
        jobTitle,
        jobType,
        jobDescription,
        qualifyAsList,
        active,
        deadLine,
        id, 
      ],
      (err, result) => {
        if (err) {
          return res.status(500).send({
            message: `Registration Failed ${err.sqlMessage} `,
            description: `${err.message} with description ${jobDescription}`,
          });
        }
  
        return res.send({ message: "Job has been updated!" });
      }
    );
  },
  
};
