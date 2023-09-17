const express = require("express");

const { createJob, fetchJob, deleteJob, displayJobs, fetchCategories,updateJob, applyJob, fetchRequest, incrementJobApplicants, fetchRequestBasedOnUser, deleteRequest, decrementJobApplicants, fetchJobsBasedOnCategories, countRows } = require("../controller/jobController");
const router = express.Router();

router.post("/create", createJob);
router.get("/fetch/:id", fetchJob);
router.delete("/delete", deleteJob);
router.post("/applyJob", applyJob,incrementJobApplicants);
router.post("/update", updateJob);
router.get("/", displayJobs);
router.get("/count", countRows);
router.get("/fetchJobsCategory/:category", fetchJobsBasedOnCategories);
router.get("/checkRequest/:id/:jobID", fetchRequestBasedOnUser);
router.get("/requests/:applicant_id", fetchRequest);
router.get("/fetchCategories", fetchCategories);
router.delete("/delete/:id", deleteJob);
router.delete(
  "/deleteRequest/:req_id/:job_id",
  deleteRequest,
  decrementJobApplicants
);

module.exports = router;
