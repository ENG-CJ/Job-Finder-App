const multer= require('multer');
const path=require('path');
const cr=require('crypto');


const upload=()=>{
    var storageEngine=multer.diskStorage({
        destination: "./public/uploads",
        filename: (req,file,cb)=>{
            cb(null,`${cr.randomUUID()}${path.extname(file.originalname)}`);
        }
    })

    return multer({
        storage: storageEngine
    })
}
module.exports.uploadImage=upload;

