const express = require('express');
const app = express();


// Environment variables
require('dotenv').config();

// Express body parser
app.use(express.json());

// Endpoint with API key
app.post('/DevOps', (req, res) => {
    const apiKeyReceived = req.header('X-Parse-REST-API-Key');

    if (apiKeyReceived !== process.env.API_KEY) {
        return res.send('ERROR');
    } 

    const { message, to, from, timeToLifeSec } = req.body;

    if (!message || !to || !from || !timeToLifeSec) {
        return res.send('ERROR');
    }

    return res.json({ message: `Hello ${to} your message will be send`})
});

// Start server
app.listen(process.env.API_PORT, () => {
    console.log('Server is running on port ' + process.env.API_PORT);
});
