const express = require("express");
const router = express.Router();
const ProductosController = require("../controllers/productosController.js");

router.get("/productos", ProductosController.obtenerProductos);

module.exports = router;