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
        message: "the record has been successfully deleted"
      });
    });
  },

  displayJobs: (req, res) => {
    var sql = "CALL displayJobsOnUserScreen()";
    db.query(sql, (err, data) => {
      if (err)
      return res.status(500).send({
        message: "there is an error occurred during login",
        errorCode: err.code,
        description: err.message,
      });
      return res.send({
        jobs: data[0],
      });
    });
  }
};
