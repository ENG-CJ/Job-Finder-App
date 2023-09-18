const express = require('express');
const { createUser, verifyUser, fetchUser, updateUser, deleteImage } = require('../controller/userController');
const { uploadImage } = require('../multer/uploadConfig');
const router=express.Router();





router.post("/register",uploadImage().single("profile_pic"), createUser);
router.post("/login",verifyUser);
router.post("/fetch",fetchUser);
router.post("/update",uploadImage().single("profile_pic"),deleteImage,updateUser);
    router.get('/notfound',(req,res)=>{
    res.status(404).send({message: 'Not Found',description: "escr"});
})

module.exports = router;