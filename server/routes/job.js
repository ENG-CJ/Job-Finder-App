const express = require("express");
const { createJob, fetchJob, deleteJob,updateJob } = require("../controller/jobController");
const router = express.Router();

router.post("/create", createJob);
router.get("/fetch/:id", fetchJob);
router.delete("/delete", deleteJob);
router.post("/update", updateJob);
module.exports = router;
