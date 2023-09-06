const express = require('express');
const { createUser, verifyUser, fetchUser, updateUser } = require('../controller/userController');
const router=express.Router();



router.post("/register",createUser);
router.post("/login",verifyUser);
router.post("/fetch",fetchUser);
router.post("/update",updateUser);
    

module.exports = router;