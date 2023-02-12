const express = require('express');
const app = express();

// Environment variables
require('dotenv').config();

// Express body parser
app.use(express.json());

// Endpoint with API key
app.post('/DevOps', (req, res) => {
    const apiKeyReceived = req.header('X-Parse-REST-API-Key');
    const jwtHeader = req.header('X-JWT-KWY');   

    // Check if API key and JWT key are correct
    if(apiKeyReceived !== process.env.API_KEY || jwtHeader !== process.env.JWT_SECRET) {
        return res.send('ERROR');
    }

    // Get data from request
    const { message, to, from, timeToLifeSec } = req.body;

    // Check if data is correct
    if (!message || !to || !from || !timeToLifeSec) {
        return res.send('ERROR');
    }

    // Return message
    return res.json({ message: `Hello ${to} your message will be send` })
});

// Start server
app.listen(process.env.API_PORT, () => {
    console.log('Server is running on port ' + process.env.API_PORT);
});
