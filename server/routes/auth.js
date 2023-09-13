const express = require('express');

const { createUser, verifyUser, fetchUser, updateUser, deleteImage } = require('../controller/userController');
const { uploadImage } = require('../multer/uploadConfig');
const router=express.Router();


const storage = multer.diskStorage({
  destination: './images/',
  filename: (req,file, callback) => {
    return callback(null, `${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`)
  }
})


router.post("/register",uploadImage().single("profile_pic"), createUser);
router.post("/login",verifyUser);
router.post("/fetch",fetchUser);
router.post("/update",uploadImage().single("profile_pic"),deleteImage,updateUser);
    

module.exports = router;