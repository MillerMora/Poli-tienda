CREATE DATABASE politienda;

USE politienda;


CREATE TABLE categorias (
    categoria_id  INT PRIMARY KEY IDENTITY(1,1),
    nombre        VARCHAR(100) NOT NULL,
    descripcion   VARCHAR(255)
);

CREATE TABLE productos (
    producto_id  INT PRIMARY KEY IDENTITY(1,1),
    categoria_id INT NOT NULL,
    titulo       VARCHAR(150) NOT NULL,
    descripcion  VARCHAR(500),
    precio       DECIMAL(10,2) NOT NULL,
    estado       VARCHAR(20) NOT NULL DEFAULT 'activo',
    FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);

CREATE TABLE clientes (
    cliente_id     INT PRIMARY KEY IDENTITY(1,1),
    nombre         VARCHAR(120) NOT NULL,
    email          VARCHAR(100) NOT NULL UNIQUE,
    telefono       VARCHAR(20),
    fecha_registro DATE NOT NULL DEFAULT GETDATE()
);

CREATE TABLE pedidos (
    pedido_id    INT PRIMARY KEY IDENTITY(1,1),
    cliente_id   INT NOT NULL,
    fecha_pedido DATETIME NOT NULL DEFAULT GETDATE(),
    total        DECIMAL(12,2) NOT NULL DEFAULT 0,
    estado       VARCHAR(20) NOT NULL DEFAULT 'pendiente',
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE detalle_pedidos (
    detalle_id      INT PRIMARY KEY IDENTITY(1,1),
    pedido_id       INT NOT NULL,
    producto_id     INT NOT NULL,
    cantidad        INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id)   REFERENCES pedidos(pedido_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

INSERT INTO categorias (nombre, descripcion) VALUES
    ('Electrónica', 'Dispositivos y gadgets electrónicos'),
    ('Ropa',        'Prendas de vestir para todas las edades'),
    ('Hogar',       'Artículos para el hogar y decoración'),
    ('Deportes',    'Equipos y accesorios deportivos');

INSERT INTO productos (categoria_id, titulo, descripcion, precio, estado) VALUES
    (1, 'Auriculares Bluetooth Pro', 'Sonido envolvente, batería de 30h',   89990.00,  'activo'),
    (1, 'Teclado Mecánico RGB',       'Switches rojos, retroiluminado',       149900.00, 'activo'),
    (1, 'Webcam Full HD 1080p',       'Para videollamadas y streaming',       59990.00,  'activo'),
    (2, 'Camiseta Algodón Premium',   'Tela 100% algodón, varios colores',   29990.00,  'activo'),
    (2, 'Chaqueta Impermeable',       'Resistente al agua, ligera',           189900.00, 'agotado'),
    (3, 'Lámpara LED de Escritorio',  'Luz regulable, puerto USB incorporado',49990.00,  'activo'),
    (3, 'Set de Almohadas Nórdicas',  'Pack x2, relleno hipoalergénico',     79990.00,  'activo'),
    (4, 'Mancuernas Ajustables 20kg', 'Par, ajuste rápido por disco',         219900.00, 'activo'),
    (4, 'Colchoneta de Yoga',         'Antideslizante, 6mm de grosor',        39990.00,  'activo');

INSERT INTO clientes (nombre, email, telefono) VALUES
    ('Andrés Torres', 'andres.torres@email.com', '3001112233'),
    ('Laura Méndez',  'laura.mendez@email.com',  '3014445566'),
    ('Carlos Ruiz',   'carlos.ruiz@email.com',   '3027778899'),
    ('Sofía Vargas',  'sofia.vargas@email.com',  NULL);

INSERT INTO pedidos (cliente_id, total, estado) VALUES
    (1, 239890.00, 'entregado'),
    (2,  89990.00, 'enviado'),
    (3, 259890.00, 'pendiente'),
    (1,  39990.00, 'pendiente');

INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario) VALUES
    (1, 1, 1,  89990.00),
    (1, 2, 1, 149900.00),
    (2, 1, 1,  89990.00),
    (3, 8, 1, 219900.00),
    (3, 9, 1,  39990.00),
    (4, 9, 1,  39990.00);
