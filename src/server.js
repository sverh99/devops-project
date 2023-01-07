require("dotenv").config();
const express = require("express");

const PORT = process.env.PORT || 5000;

console.log({ PORT });

const app = express();

app.get("/ping", (req, res) => {
  res.send("pong");
});

app.get("/", (req, res) => {
  res.send("Hello world");
});

const server = app.listen(PORT);

module.exports = server;
