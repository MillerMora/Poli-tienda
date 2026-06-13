const ProductosModel = require("../models/productoModel.js");

class ProductosController {
  static async obtenerProductos(req, res) {
    try {
      const productos = await ProductosModel.obtenerProductos();
      res.status(200).json(productos);
    } catch (error) {
      console.error("Error al obtener productos:", error);
      res.status(500).json({ mensaje: "Error interno del servidor" });
    }
  }
}

module.exports = ProductosController;