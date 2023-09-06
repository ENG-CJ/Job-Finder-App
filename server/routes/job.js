const express = require("express");
const { createJob, fetchJob, deleteJob } = require("../controller/jobController");
const router = express.Router();

router.post("/create", createJob);
router.get("/fetch/:id", fetchJob);
router.delete("/delete/:id", deleteJob);
module.exports = router;
