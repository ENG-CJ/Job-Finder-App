const db = require("../db/db");
const cr = require("crypto");

module.exports = {
  countRows:(req,res,next)=>{
    var {table,owner_id,status}=req.query;
    switch (table) {
      case "jobs":
        var sql = `SELECT COUNT(*) as rowCount FROM jobs WHERE owner=?`;
        db.query(sql, [owner_id], (err, data) => {
          if (err)
            return res.status(500).send({
              message: `Fetching Failed ${err.sqlMessage}`,
              description: err.message,
            });
          res.send({ numberOfRows: data[0].rowCount });
        });
        break;
      case "requests":
        var sql = `
          SELECT COUNT(*) as rowCount FROM requests 
          INNER JOIN jobs
          ON requests.job_id=jobs.id
          INNER JOIN users
          ON jobs.owner=users.id
          WHERE jobs.owner=?`;
        db.query(sql, [owner_id], (err, data) => {
          if (err)
            return res.status(500).send({
              message: `Fetching Failed ${err.sqlMessage}`,
              description: err.message,
            });
          res.send({ numberOfRows: data[0].rowCount });
        });
        break;

      case "rejectedRequests":
        var sql = `
          SELECT COUNT(*) as rowCount FROM requests 
          INNER JOIN jobs
          ON requests.job_id=jobs.id
          INNER JOIN users
          ON jobs.owner=users.id
          WHERE jobs.owner=? AND requests.status=?`;
        db.query(sql, [owner_id, status], (err, data) => {
          if (err)
            return res.status(500).send({
              message: `Fetching Failed ${err.sqlMessage}`,
              description: err.message,
            });
          res.send({ numberOfRows: data[0].rowCount });
        });
        break;
      case "acceptedRequests":
        var sql = `
          SELECT COUNT(*) as rowCount FROM requests 
          INNER JOIN jobs
          ON requests.job_id=jobs.id
          INNER JOIN users
          ON jobs.owner=users.id
          WHERE jobs.owner=? AND requests.status=?`;
        db.query(sql, [owner_id, status], (err, data) => {
          if (err)
            return res.status(500).send({
              message: `Fetching Failed ${err.sqlMessage}`,
              description: err.message,
            });
          res.send({ numberOfRows: data[0].rowCount });
        });
        break;
      case "pendingRequests":
        var sql = `
          SELECT COUNT(*) as rowCount FROM requests 
          INNER JOIN jobs
          ON requests.job_id=jobs.id
          INNER JOIN users
          ON jobs.owner=users.id
          WHERE jobs.owner=? AND requests.status=?`;
        db.query(sql, [owner_id, status], (err, data) => {
          if (err)
            return res.status(500).send({
              message: `Fetching Failed ${err.sqlMessage}`,
              description: err.message,
            });
          res.send({ numberOfRows: data[0].rowCount });
        });
        break;

      default:
        break;
    }
  
  },
  deleteRequest: (req, res, next) => {
    var sql = "DELETE FROM requests WHERE req_id=?";
    db.query(sql, [req.params.req_id], (err, data) => {
      if (err)
        return res.status(500).send({
          message: `Deleting Failed ${err.sqlMessage}`,
          description: err.message,
        });
      next();
    });
  },
  fetchRequestBasedOnUser: (req, res) => {
    var sql = "SELECT * FROM requests where applicant_id=? and job_id=?";
    db.query(sql, [req.params.id, req.params.jobID], (err, data) => {
      if (err)
        return res.status(500).send({
          message: `Fetching Failed ${err.sqlMessage}`,
          description: err.message,
        });
      res.send({ jobs: data });
    });
  },
  fetchRequest: (req, res) => {
    var sql =
      "SELECT req_id,applicant_id,job_id,request_date,status,jobs.jobTitle,users.username,users.profile_pic FROM requests INNER JOIN jobs on requests.job_id=jobs.id INNER JOIN users on jobs.owner=users.id where applicant_id=?";
    db.query(sql, [req.params.applicant_id], (err, data) => {
      if (err)
        return res.status(500).send({
          message: `Fetching Failed ${err.sqlMessage}`,
          description: err.message,
        });
      res.send({ requests: data });
    });
  },
  incrementJobApplicants: (req, res) => {
    var sql = "UPDATE jobs SET applicants=applicants+1 WHERE id=?";
    db.query(sql, [req.body.job_id], (err, data) => {
      if (err)
        return res.status(500).send({
          message: `updating Failed ${err.sqlMessage}`,
          description: err.message,
        });
      res.send({
        message:
          "Your Request Has been sent, Wait Until The Owner Verified or accept your request",
      });
    });
  },
  decrementJobApplicants: (req, res) => {
    var sql = "UPDATE jobs SET applicants=applicants-1 WHERE id=?";
    db.query(sql, [req.params.job_id], (err, data) => {
      if (err)
        return res.status(500).send({
          message: `updating Failed ${err.sqlMessage}`,
          description: err.message,
        });
      res.send({
        message:
          "Your Request Has been removed, Wait Until The Owner Verified or accept your request",
      });
    });
  },
  applyJob: (req, res, next) => {
    var query =
      "INSERT INTO `requests`(`applicant_id`, `job_id`, `request_date`) VALUES (?,?,?)";
    db.query(
      query,
      [req.body.applicant_id, req.body.job_id, req.body.date],
      (err, data) => {
        if (err) {
          return res.status(500).send({
            message: `Request Failed ${err.sqlMessage}`,
            description: err.message,
          });
        }
        next();
      }
    );
  },
  fetchCategories: (req, res) => {
    var sql = "SELECT DISTINCT category from jobs";
    db.query(sql, (err, data) => {
      if (err)
        return res.status(500).send({
          message: `Fetching Failed ${err.sqlMessage}`,
          description: err.message,
        });
      res.send({ categories: data });
    });
  },
  createJob: (req, res) => {
    const {
      jobTitle,
      jobType,
      jobDescription,
      deadLine,
      active,
      applicants,
      owner,
      category,
      qualifyAsList,
      posted,
    } = req.body;
    var sql = "CALL createJob(?,?,?,?,?,?,?,?,?,?,?)";
    db.query(
      sql,
      [
        cr.randomUUID(),
        jobTitle,
        category,
        jobType,
        jobDescription,
        qualifyAsList,
        active,
        applicants,
        owner,
        deadLine,
        posted
      ],
      (err, data) => {
        if (err) {
          return res.status(500).send({
            message: `Registration Failed ${err.sqlMessage}`,
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
  },

  fetchJobsBasedOnCategories: (req, res) => {
    var sql = "CALL fetchJobsBasedOnCategory(?)";
    db.query(sql, [req.params.category],(err, data) => {
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
      [jobTitle, jobType, jobDescription, qualifyAsList, active, deadLine, id],
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
