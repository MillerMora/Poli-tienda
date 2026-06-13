const express = require("express");
const cors = require("cors");
const router = require("./routes/router.js");

const app = express();

app.use(cors());
app.use(express.json());
app.use("/api", router);

app.listen(4000, () => {
  console.log("Servidor corriendo en http://localhost:4000");
});