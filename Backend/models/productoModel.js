const db = require("../config/database.js");

class ProductosModel {
  static async obtenerProductos() {
    const basedatos = await db();
    const resultados = await basedatos.query("select * from productos");
    return resultados.recordset;
  }
}

(async () => {
    const productos = await ProductosModel.obtenerProductos()
    console.log(productos)
}) ()