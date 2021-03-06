const fs = require("fs");
const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const app = express();
const port = 3000;

app.use(cors());
app.get("/", (req, res) => res.send("Hello World!"));
app.post("/submit-answers", bodyParser.json(), (req, res) => {
  console.log(req.body);
  fs.writeFileSync(`/tmp/answers-${Date.now()}.json`, JSON.stringify(req.body));
  res.send("ok");
});

app.listen(port, () => console.log(`Example app listening on port ${port}!`));
