const express = require('express');
const { createUser, verifyUser, fetchUser } = require('../controller/userController');
const router=express.Router();



router.post("/register",createUser);
router.post("/login",verifyUser);
router.post("/fetch",fetchUser);

module.exports = router;