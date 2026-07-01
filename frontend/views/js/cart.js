const Carrito = (() => {
    const CARRITO_KEY = "politienda_carrito";
    const PRODUCTO_SELECCIONADO_KEY = "politienda_producto_seleccionado";
    const ENVIO_ESTIMADO = 8000; // valor fijo solo para la simulación

    // ---------- utilidades internas ----------

    function obtener() {
        try {
            const data = JSON.parse(localStorage.getItem(CARRITO_KEY));
            return Array.isArray(data) ? data : [];
        } catch (error) {
            return [];
        }
    }

    function guardar(carrito) {
        localStorage.setItem(CARRITO_KEY, JSON.stringify(carrito));
        actualizarBadge();
    }

    function formatoPrecio(numero) {
        return "$" + Number(numero || 0).toLocaleString("es-CO");
    }

    // ---------- API pública ----------

    function agregar(producto, cantidad = 1) {
        const id = producto.id_Producto ?? producto.id;
        if (id === undefined || id === null) {
            console.error("Producto sin id, no se puede agregar al carrito:", producto);
            return obtener();
        }

        const carrito = obtener();
        const existente = carrito.find(item => item.id === id);

        if (existente) {
            existente.cantidad += cantidad;
        } else {
            carrito.push({
                id,
                titulo: producto.titulo,
                precio: Number(producto.precio) || 0,
                imagen: producto.imagen,
                descripcion: producto.descripcion || "",
                cantidad
            });
        }

        guardar(carrito);
        return carrito;
    }

    function eliminar(id) {
        const carrito = obtener().filter(item => item.id !== id);
        guardar(carrito);
        return carrito;
    }

    function actualizarCantidad(id, cantidad) {
        let carrito = obtener();
        if (cantidad <= 0) {
            carrito = carrito.filter(item => item.id !== id);
        } else {
            const item = carrito.find(item => item.id === id);
            if (item) item.cantidad = cantidad;
        }
        guardar(carrito);
        return carrito;
    }

    function vaciar() {
        guardar([]);
    }

    function totalItems() {
        return obtener().reduce((acumulado, item) => acumulado + item.cantidad, 0);
    }

    function calcularTotales() {
        const carrito = obtener();
        const subtotal = carrito.reduce((acumulado, item) => acumulado + item.precio * item.cantidad, 0);
        const envio = carrito.length > 0 ? ENVIO_ESTIMADO : 0;
        return {
            subtotal,
            envio,
            total: subtotal + envio
        };
    }

    function actualizarBadge() {
        const badge = document.getElementById("cartBadge");
        if (!badge) return;
        const cantidad = totalItems();
        badge.textContent = cantidad;
        badge.style.display = cantidad > 0 ? "flex" : "none";
    }

    // Guarda el producto elegido en "Ver detalle" para poder pintarlo
    // en DetallePedido.html (no hay endpoint GET /productos/:id todavía)
    function guardarProductoSeleccionado(producto) {
        localStorage.setItem(PRODUCTO_SELECCIONADO_KEY, JSON.stringify(producto));
    }

    function obtenerProductoSeleccionado() {
        try {
            return JSON.parse(localStorage.getItem(PRODUCTO_SELECCIONADO_KEY));
        } catch (error) {
            return null;
        }
    }

    // Simula el proceso de compra: valida, "genera" un pedido y vacía el carrito
    function realizarCompraSimulada() {
        const carrito = obtener();
        if (carrito.length === 0) {
            return { ok: false, mensaje: "Tu carrito está vacío." };
        }

        const totales = calcularTotales();
        const pedido = {
            numeroPedido: "PT-" + Date.now().toString().slice(-8),
            fecha: new Date().toLocaleString("es-CO"),
            items: carrito,
            ...totales
        };

        vaciar();
        return { ok: true, pedido };
    }

    return {
        obtener,
        agregar,
        eliminar,
        actualizarCantidad,
        vaciar,
        totalItems,
        calcularTotales,
        actualizarBadge,
        formatoPrecio,
        guardarProductoSeleccionado,
        obtenerProductoSeleccionado,
        realizarCompraSimulada
    };
})();

document.addEventListener("DOMContentLoaded", () => Carrito.actualizarBadge());
