const express = require('express');
const app = express();
const path = require('path');
const staticPath = path.join(__dirname, 'static');
console.log(`Serving static website files from: ${staticPath}`);

app.use('/static', express.static(staticPath));

app.listen(2000, () => {
    console.log("Server running on port 2000")
})