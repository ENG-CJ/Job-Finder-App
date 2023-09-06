const express = require('express');
const bodyParser = require('body-parser');
const authRoute  = require('./routes/auth')
const jobRoute  = require('./routes/job')


const app = express();
app.use(express.json())
app.use(express.urlencoded({extended: true}));



app.use('/users',authRoute);
app.use('/jobs',jobRoute);
    


const PORT = process.env.PORT || 9999;
app.listen(PORT,  ()=> {
    console.log(`Listening at port: ${PORT}`);
})



