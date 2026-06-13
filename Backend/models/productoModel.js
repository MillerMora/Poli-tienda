const db = require("../config/database.js");

class ProductosModel {
  static async obtenerProductos() {
    const basedatos = await db();
    const resultados = await basedatos.query("SELECT * FROM productos");
    return resultados.recordset;
  }
}

module.exports = ProductosModel;