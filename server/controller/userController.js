const express = require('express');
const User = require('../model/user')



const userRouter = express.Router();

userRouter.post('/register', (req,res) => {
    const { username,email,password,type,phone,address,city,country } = req.body;

    User.createUser(username,email,password,type,phone,address,city,country, (err, result) => {
        if(err) {
            console.log(`There is an error: ${err}`);
            return res.status(500).json({ err: `Registration Failed ${err}` });
        }
        res.json( { message: 'User registered successfully' } );
    })
    
    
})

module.exports = userRouter;