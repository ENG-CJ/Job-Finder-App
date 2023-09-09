const express = require("express");
const { createJob, fetchJob, deleteJob, displayJobs } = require("../controller/jobController");
const router = express.Router();

router.post("/create", createJob);
router.get("/fetch/:id", fetchJob);
router.get("/", displayJobs);
router.delete("/delete/:id", deleteJob);

module.exports = router;
