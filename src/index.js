import app from "../src/app.js";

// Start server
app.listen(process.env.API_PORT, () => {
    console.log('Server is running on port ' + process.env.API_PORT);
});