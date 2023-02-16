import { createRequire } from 'module';
const require = createRequire(import.meta.url);
import express from 'express';
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
        return res.status(404).send('ERROR');
    }

    // Get data from request
    const { message, to, from, timeToLifeSec } = req.body;

    // Check if data is correct
    if (!message || !to || !from || !timeToLifeSec) {
        return res.status(404).send('ERROR');
    }

    // Return message
    return res.status(200).json({ message: `Hello ${to} your message will be send` })
});

// Export app
export default app;