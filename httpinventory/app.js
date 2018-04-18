const express = require('express')
const app = express()
const multer = require('multer')
const upload = multer()
const bodyParser = require('body-parser')
app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

var THE_INVENTORY = [1, 2, 3];

// responds with the inventory JSON encoded
app.post('/getinventory', (req, res) => {
  res.json(THE_INVENTORY);
})

app.post('/setinventory', upload.array(), (req, res) => {
    THE_INVENTORY = req.body['payload'];
    console.log(THE_INVENTORY);
    res.json('good');
});

app.listen(7000, () => console.log('Example app listening on port 7000!'))