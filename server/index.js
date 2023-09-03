const express = require('express');
const bodyParser = require('body-parser');
const authRoute  = require('./routes/auth')


const app = express();

app.use(bodyParser.json());
app.use(authRoute);
    


const PORT = process.env.PORT || 9999;
app.listen(PORT,  ()=> {
    console.log(`Listening at port: ${PORT}`);
})



