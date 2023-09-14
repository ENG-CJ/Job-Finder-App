const express = require("express");
const { createJob, fetchJob, deleteJob,updateJob,displayJobs,fetchCategories} = require("../controller/jobController");
// const { createJob, fetchJob, deleteJob, displayJobs, fetchCategories } = require("../controller/jobController");
const router = express.Router();

router.post("/create", createJob);
router.get("/fetch/:id", fetchJob);
router.delete("/delete", deleteJob);
router.post("/update", updateJob);
router.get("/", displayJobs);
router.get("/fetchCategories", fetchCategories);
router.delete("/delete/:id", deleteJob);

module.exports = router;
