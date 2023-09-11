const express = require('express');
const { createUser, verifyUser, fetchUser, updateUser } = require('../controller/userController');
const multer = require('multer');
const path = require('path');
const router=express.Router();


const storage = multer.diskStorage({
  destination: './images/',
  filename: (req,file, callback) => {
    return callback(null, `${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`)
  }
})

const upload = multer({ storage: storage });

router.post("/register", upload.single('profile_pic') ,createUser);
router.post("/login",verifyUser);
router.post("/fetch",fetchUser);
router.post("/update",updateUser);
    

module.exports = router;