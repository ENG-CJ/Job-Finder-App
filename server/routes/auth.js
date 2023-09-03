const express = require('express');
const userController = require('../controller/userController');


const authRouter = express.Router();

authRouter.use('/api',userController);


module.exports = authRouter;