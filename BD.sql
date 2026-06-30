CREATE DATABASE politienda;

USE politienda;

CREATE TABLE Usuarios (
    id_Usuario     INT           IDENTITY(1,1) PRIMARY KEY,
    nombre         NVARCHAR(100) NOT NULL,
    email          NVARCHAR(150) NOT NULL,
    password       NVARCHAR(255) NOT NULL,
    telefono       NVARCHAR(20),
    fecha_registro DATE          NOT NULL,
    CONSTRAINT UQ_Usuarios_email UNIQUE (email)
);

CREATE TABLE Categorias (
    id_Categoria INT           IDENTITY(1,1) PRIMARY KEY,
    nombre       NVARCHAR(100) NOT NULL,
    descripcion  NVARCHAR(255)
);

CREATE TABLE productos (
    id_Producto  INT            IDENTITY(1,1) PRIMARY KEY,
    Categoria_id INT            NOT NULL,
    titulo       NVARCHAR(150)  NOT NULL,
    descripcion  NVARCHAR(500),
    precio       DECIMAL(10,2)  NOT NULL,
    stock        INT NOT NULL,
    imagen       NVARCHAR(255) NOT NULL,
    Estado       NVARCHAR(50)   NOT NULL,
    CONSTRAINT FK_productos_Categorias FOREIGN KEY (Categoria_id)
        REFERENCES Categorias (id_Categoria)
);

CREATE TABLE Carrito (
    id_Carrito INT           IDENTITY(1,1) PRIMARY KEY,
    Usuario_id INT           NOT NULL,
    fecha      DATE          NOT NULL,
    Estado     NVARCHAR(50)  NOT NULL,
    CONSTRAINT FK_Carrito_Usuarios FOREIGN KEY (Usuario_id)
        REFERENCES Usuarios (id_Usuario)
);

CREATE TABLE carrito_items (
    id_Item        INT           IDENTITY(1,1) PRIMARY KEY,
    producto_id    INT           NOT NULL,
    carrito_id     INT           NOT NULL,
    cantidad       INT           NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_carrito_items_productos FOREIGN KEY (producto_id)
        REFERENCES productos (id_Producto),
    CONSTRAINT FK_carrito_items_Carrito   FOREIGN KEY (carrito_id)
        REFERENCES Carrito (id_Carrito)
);

CREATE TABLE pedidos (
    id_Pedido       INT            IDENTITY(1,1) PRIMARY KEY,
    Usuario_id      INT            NOT NULL,
    Carrito_id      INT            NOT NULL,
    direccion_envio NVARCHAR(300)  NOT NULL,
    fecha_pedido    DATE           NOT NULL,
    total           DECIMAL(10,2)  NOT NULL,
    estado          NVARCHAR(50)   NOT NULL,
    CONSTRAINT FK_pedidos_Usuarios FOREIGN KEY (Usuario_id)
        REFERENCES Usuarios (id_Usuario),
    CONSTRAINT FK_pedidos_Carrito  FOREIGN KEY (Carrito_id)
        REFERENCES Carrito (id_Carrito)
);

CREATE TABLE resenas (
    id_Resena    INT           IDENTITY(1,1) PRIMARY KEY,
    Pedido_id    INT           NOT NULL,
    Producto_id  INT           NOT NULL,
    Usuario_id   INT           NOT NULL,
    calificacion TINYINT       NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
    comentario   NVARCHAR(500),
    fecha        DATE          NOT NULL,
    CONSTRAINT FK_resenas_pedidos   FOREIGN KEY (Pedido_id)
        REFERENCES pedidos (id_Pedido),
    CONSTRAINT FK_resenas_productos FOREIGN KEY (Producto_id)
        REFERENCES productos (id_Producto),
    CONSTRAINT FK_resenas_Usuarios  FOREIGN KEY (Usuario_id)
        REFERENCES Usuarios (id_Usuario)
);

CREATE TABLE Pagos (
    id_Pago    INT            IDENTITY(1,1) PRIMARY KEY,
    pedidos_id INT            NOT NULL,
    metodo     NVARCHAR(50)   NOT NULL,
    referencia NVARCHAR(100),
    monto      DECIMAL(10,2)  NOT NULL,
    Estado     NVARCHAR(50)   NOT NULL,
    fecha_pago DATE           NOT NULL,
    CONSTRAINT FK_Pagos_pedidos FOREIGN KEY (pedidos_id)
        REFERENCES pedidos (id_Pedido)
);

INSERT INTO Usuarios (nombre, email, password, telefono, fecha_registro) VALUES
( 'Carlos Mendoza',    'carlos.mendoza@gmail.com',    'hash_pass_001', '3001234567', '2023-01-15'),
( 'Laura Pérez',       'laura.perez@hotmail.com',     'hash_pass_002', '3112345678', '2023-02-20'),
( 'Andrés Torres',     'andres.torres@outlook.com',   'hash_pass_003', '3223456789', '2023-03-05'),
( 'María González',    'maria.gonzalez@yahoo.com',    'hash_pass_004', '3134567890', '2023-04-10'),
( 'Jorge Ramírez',     'jorge.ramirez@gmail.com',     'hash_pass_005', '3005678901', '2023-05-18'),
( 'Sofía Herrera',     'sofia.herrera@gmail.com',     'hash_pass_006', '3166789012', '2023-06-22'),
( 'Daniel Castro',     'daniel.castro@hotmail.com',   'hash_pass_007', '3207890123', '2023-07-30'),
( 'Valentina Ríos',    'valentina.rios@outlook.com',  'hash_pass_008', '3018901234', '2023-08-14'),
( 'Miguel Vargas',     'miguel.vargas@gmail.com',     'hash_pass_009', '3129012345', '2023-09-01'),
( 'Isabella Moreno',   'isabella.moreno@yahoo.com',   'hash_pass_010', '3230123456', '2023-09-25'),
( 'Sebastián López',   'sebastian.lopez@gmail.com',   'hash_pass_011', '3001234568', '2023-10-08'),
( 'Camila Díaz',       'camila.diaz@hotmail.com',     'hash_pass_012', '3112345679', '2023-10-15'),
( 'Julián Ortiz',      'julian.ortiz@gmail.com',      'hash_pass_013', '3223456780', '2023-11-02'),
( 'Lucía Flores',      'lucia.flores@outlook.com',    'hash_pass_014', '3134567891', '2023-11-20'),
( 'Tomás Reyes',       'tomas.reyes@gmail.com',       'hash_pass_015', '3005678902', '2023-12-01'),
( 'Natalia Gómez',     'natalia.gomez@yahoo.com',     'hash_pass_016', '3166789013', '2023-12-12'),
( 'Esteban Jiménez',   'esteban.jimenez@gmail.com',   'hash_pass_017', '3207890124', '2024-01-05'),
( 'Alejandra Silva',   'alejandra.silva@hotmail.com', 'hash_pass_018', '3018901235', '2024-01-18'),
( 'Ricardo Muñoz',     'ricardo.munoz@gmail.com',     'hash_pass_019', '3129012346', '2024-02-10'),
( 'Paola Suárez',      'paola.suarez@outlook.com',    'hash_pass_020', '3230123457', '2024-02-28');

INSERT INTO Categorias (nombre, descripcion) VALUES
('Línea Blanca',        'Neveras, lavadoras, secadoras y congeladores'),
('Cocina',              'Estufas, hornos, microondas y campanas extractoras'),
('Climatización',       'Aires acondicionados, ventiladores y calefactores'),
('Pequeños Electrodomésticos', 'Licuadoras, tostadoras, cafeteras y freidoras'),
('Lavado y Planchado',  'Lavadoras, centrifugadoras y planchas de vapor'),
('Entretenimiento',     'Televisores, barras de sonido y proyectores'),
('Iluminación',         'Bombillas inteligentes, lámparas y sistemas de luz'),
('Cuidado Personal',    'Secadores de cabello, afeitadoras y epiladoras'),
('Herramientas Eléctricas', 'Taladros, pulidoras y aspiradoras'),
('Cocina Profesional',  'Equipos de cocina de alta gama para uso intensivo');

INSERT INTO productos (Categoria_id, titulo, descripcion, precio, stock, imagen, Estado) VALUES
(1, 'Nevera Samsung No Frost 400L',        'Refrigerador inverter twin cooling, dispensador de agua',        2899000.00, 15, 'https://placehold.co/600x400/2563eb/ffffff?text=Nevera+Samsung', 'Activo'),
(1, 'Lavadora LG 22kg Carga Frontal',      'Lavadora con inteligencia artificial, vapor y TurboWash',        2499000.00, 10, 'https://placehold.co/600x400/2563eb/ffffff?text=Lavadora+LG', 'Activo'),
(1, 'Congelador Challenger 300L',          'Congelador horizontal, control digital, bajo consumo',            999000.00, 8,  'https://placehold.co/600x400/2563eb/ffffff?text=Congelador+Challenger', 'Activo'),
(2, 'Estufa Mabe 4 Puestos a Gas',         'Estufa de acero inoxidable con horno incluido 76cm',              989000.00, 12, 'https://placehold.co/600x400/16a34a/ffffff?text=Estufa+Mabe', 'Activo'),
(2, 'Microondas Whirlpool 30L',            'Microondas con grill, 10 niveles de potencia, 900W',              459000.00, 20, 'https://placehold.co/600x400/16a34a/ffffff?text=Microondas+Whirlpool', 'Activo'),
(2, 'Horno Eléctrico Haceb 60L',           'Horno eléctrico empotrable con convección y grill',              1299000.00, 7,  'https://placehold.co/600x400/16a34a/ffffff?text=Horno+Haceb', 'Activo'),
(3, 'Aire Acondicionado LG Inverter 12000 BTU', 'Mini split inverter, WiFi, modo turbo y ahorro energía',    2199000.00, 9,  'https://placehold.co/600x400/dc2626/ffffff?text=Aire+LG', 'Activo'),
(3, 'Ventilador de Torre Philips 90cm',    'Ventilador sin aspas con control remoto y temporizador',           389000.00, 25, 'https://placehold.co/600x400/dc2626/ffffff?text=Ventilador+Philips', 'Activo'),
(4, 'Licuadora Oster 1200W',               'Licuadora de alto rendimiento, vaso de vidrio 1.5L',              289000.00, 30, 'https://placehold.co/600x400/ea580c/ffffff?text=Licuadora+Oster', 'Activo'),
(4, 'Freidora de Aire Philips Airfryer 4L','Freidora sin aceite, pantalla digital, 7 programas',              699000.00, 18, 'https://placehold.co/600x400/ea580c/ffffff?text=Airfryer+Philips', 'Activo'),
(4, 'Cafetera Nespresso Vertuo Pop',       'Cafetera de cápsulas 1500W, 5 tamaños de taza',                  499000.00, 22, 'https://placehold.co/600x400/ea580c/ffffff?text=Cafetera+Nespresso', 'Activo'),
(5, 'Lavadora Whirlpool 16kg Carga Superior','Lavadora automática con ciclo rápido 30 minutos',              1399000.00, 11, 'https://placehold.co/600x400/9333ea/ffffff?text=Lavadora+Whirlpool', 'Activo'),
(5, 'Plancha de Vapor Oster SteamMax',     'Plancha cerámica con golpe de vapor, 2600W',                      179000.00, 35, 'https://placehold.co/600x400/9333ea/ffffff?text=Plancha+Oster', 'Activo'),
(6, 'Televisor Samsung QLED 55" 4K',       'Smart TV QLED, HDR10+, Tizen OS, 120Hz',                        3499000.00, 6,  'https://placehold.co/600x400/0891b2/ffffff?text=TV+Samsung+QLED', 'Activo'),
(6, 'Barra de Sonido LG 2.1 300W',         'Soundbar con subwoofer inalámbrico, Bluetooth 5.0',               899000.00, 14, 'https://placehold.co/600x400/0891b2/ffffff?text=Barra+Sonido+LG', 'Activo'),
(7, 'Kit Bombillas LED Inteligentes Philips Hue', 'Pack 3 bombillas WiFi con 16 millones de colores',         459000.00, 40, 'https://placehold.co/600x400/65a30d/ffffff?text=Bombillas+Hue', 'Activo'),
(8, 'Secador de Cabello Dyson Supersonic', 'Secador profesional motor V9, control de temperatura inteligente',1899000.00, 13, 'https://placehold.co/600x400/be185d/ffffff?text=Secador+Dyson', 'Activo'),
(9, 'Aspiradora Robot iRobot Roomba j7',   'Robot aspirador con mapeo inteligente y vaciado automático',     2299000.00, 9,  'https://placehold.co/600x400/4338ca/ffffff?text=Roomba+j7', 'Activo'),
(9, 'Aspiradora Vertical Dyson V15',       'Aspiradora inalámbrica con sensor láser de partículas',          1799000.00, 10, 'https://placehold.co/600x400/4338ca/ffffff?text=Dyson+V15', 'Activo'),
(10,'Batidora KitchenAid Artisan 4.8L',    'Batidora de pedestal profesional, 10 velocidades, 300W',         2199000.00, 16, 'https://placehold.co/600x400/d97706/ffffff?text=KitchenAid+Artisan', 'Activo');

INSERT INTO Carrito (Usuario_id, fecha, Estado) VALUES
( 1, '2024-01-10', 'Completado'),
( 2, '2024-01-15', 'Completado'),
( 3, '2024-01-20', 'Completado'),
( 4, '2024-02-05', 'Completado'),
( 5, '2024-02-10', 'Completado'),
( 6, '2024-02-18', 'Completado'),
( 7, '2024-03-01', 'Completado'),
( 8, '2024-03-10', 'Completado'),
( 9, '2024-03-22', 'Completado'),
(10, '2024-04-05', 'Completado'),
(11, '2024-04-15', 'Activo'),
(12, '2024-04-20', 'Activo'),
(13, '2024-05-02', 'Completado'),
(14, '2024-05-12', 'Completado'),
(15, '2024-05-20', 'Completado'),
(16, '2024-06-01', 'Activo'),
(17, '2024-06-08', 'Completado'),
(18, '2024-06-15', 'Completado'),
(19, '2024-06-22', 'Activo'),
(20, '2024-06-30', 'Completado');

INSERT INTO carrito_items (producto_id, carrito_id, cantidad, precio_unitario) VALUES
( 1,  1, 1, 2899000.00),  
( 2,  1, 1, 2499000.00),  
( 4,  2, 1,  989000.00),  
( 5,  2, 1,  459000.00), 
( 7,  3, 1, 2199000.00),  
( 8,  3, 2,  389000.00),  
( 9,  4, 1,  289000.00), 
(10,  4, 1,  699000.00), 
(11,  4, 1,  499000.00), 
(14,  5, 1, 3499000.00), 
(15,  5, 1,  899000.00), 
( 3,  6, 1,  999000.00),  
(12,  6, 1, 1399000.00), 
(13,  7, 2,  179000.00), 
(16,  7, 1,  459000.00), 
(17,  8, 1, 1899000.00), 
(18,  9, 1, 2299000.00), 
(19,  9, 1, 1799000.00), 
(20, 10, 1, 2199000.00), 
( 6, 10, 1, 1299000.00), 
( 5, 13, 2,  459000.00), 
(10, 14, 1,  699000.00), 
( 7, 15, 1, 2199000.00), 
( 9, 17, 1,  289000.00),  
(14, 18, 1, 3499000.00);  

INSERT INTO pedidos (Usuario_id, Carrito_id, direccion_envio, fecha_pedido, total, estado) VALUES
( 1,  1, 'Cra 15 #85-20 Apto 301, Bogotá',      '2024-01-11', 5398000.00, 'Entregado'),
( 2,  2, 'Calle 72 #45-10, Medellín',            '2024-01-16', 1448000.00, 'Entregado'),
( 3,  3, 'Av. El Dorado #68C-61, Bogotá',        '2024-01-21', 2977000.00, 'Entregado'),
( 4,  4, 'Cra 43A #5A-113, Medellín',            '2024-02-06', 1487000.00, 'Entregado'),
( 5,  5, 'Calle 98 #19-52 Of 201, Bogotá',       '2024-02-11', 4398000.00, 'Entregado'),
( 6,  6, 'Cra 1 #15-25, Santa Marta',            '2024-02-19', 2398000.00, 'Entregado'),
( 7,  7, 'Calle 5 #36-08, Cali',                 '2024-03-02',  817000.00, 'Entregado'),
( 8,  8, 'Cra 7 #32-16, Barranquilla',           '2024-03-11', 1899000.00, 'Entregado'),
( 9,  9, 'Calle 44 #55-22, Bucaramanga',         '2024-03-23', 4098000.00, 'Entregado'),
(10, 10, 'Cra 19 #22-45, Pereira',               '2024-04-06', 3498000.00, 'Entregado'),
(11, 11, 'Calle 80 #90-15 Casa 3, Bogotá',       '2024-04-16',  159000.00, 'Procesando'),
(12, 12, 'Cra 25 #14-60, Manizales',             '2024-04-21',  199000.00, 'Procesando'),
(13, 13, 'Av. Las Palmas Km 2, Medellín',        '2024-05-03',  918000.00, 'En tránsito'),
(14, 14, 'Cra 52 #74-25, Barranquilla',          '2024-05-13',  699000.00, 'Procesando'),
(15, 15, 'Calle 13 #82-67, Bogotá',              '2024-05-21', 2199000.00, 'Entregado'),
(16, 16, 'Cra 10 #15-30, Cartagena',             '2024-06-02',  289000.00, 'Procesando'),
(17, 17, 'Calle 34 #20-15, Cúcuta',              '2024-06-09',  289000.00, 'Entregado'),
(18, 18, 'Cra 8 #44-20, Bucaramanga',            '2024-06-16', 3499000.00, 'En tránsito'),
(19, 19, 'Calle 70 #55-10, Bogotá',              '2024-06-23',  699000.00, 'Procesando'),
(20, 20, 'Cra 30 #12-50 Apto 401, Medellín',     '2024-07-01', 2199000.00, 'Entregado');

INSERT INTO Pagos (pedidos_id, metodo, referencia, monto, Estado, fecha_pago) VALUES
( 1, 'Tarjeta Crédito', 'REF-TC-20240111-001', 5398000.00, 'Aprobado',  '2024-01-11'),
( 2, 'PSE',             'REF-PSE-20240116-002',1448000.00, 'Aprobado',  '2024-01-16'),
( 3, 'Nequi',           'REF-NQ-20240121-003', 2977000.00, 'Aprobado',  '2024-01-21'),
( 4, 'Tarjeta Débito',  'REF-TD-20240206-004', 1487000.00, 'Aprobado',  '2024-02-06'),
( 5, 'PSE',             'REF-PSE-20240211-005',4398000.00, 'Aprobado',  '2024-02-11'),
( 6, 'Tarjeta Crédito', 'REF-TC-20240219-006', 2398000.00, 'Aprobado',  '2024-02-19'),
( 7, 'Daviplata',       'REF-DP-20240302-007',  817000.00, 'Aprobado',  '2024-03-02'),
( 8, 'Nequi',           'REF-NQ-20240311-008', 1899000.00, 'Aprobado',  '2024-03-11'),
( 9, 'Tarjeta Crédito', 'REF-TC-20240323-009', 4098000.00, 'Aprobado',  '2024-03-23'),
(10, 'PSE',             'REF-PSE-20240406-010',3498000.00, 'Aprobado',  '2024-04-06'),
(11, 'Tarjeta Crédito', 'REF-TC-20240416-011',  159000.00, 'Pendiente', '2024-04-16'),
(12, 'PSE',             'REF-PSE-20240421-012',  199000.00, 'Pendiente', '2024-04-21'),
(13, 'Daviplata',       'REF-DP-20240503-013',  918000.00, 'Pendiente', '2024-05-03'),
(14, 'Tarjeta Débito',  'REF-TD-20240513-014',  699000.00, 'Pendiente', '2024-05-13'),
(15, 'Nequi',           'REF-NQ-20240521-015', 2199000.00, 'Aprobado',  '2024-05-21'),
(16, 'Tarjeta Crédito', 'REF-TC-20240602-016',  289000.00, 'Pendiente', '2024-06-02'),
(17, 'PSE',             'REF-PSE-20240609-017',  289000.00, 'Aprobado',  '2024-06-09'),
(18, 'Nequi',           'REF-NQ-20240616-018', 3499000.00, 'Pendiente', '2024-06-16'),
(19, 'Daviplata',       'REF-DP-20240623-019',  699000.00, 'Pendiente', '2024-06-23'),
(20, 'Tarjeta Crédito', 'REF-TC-20240701-020', 2199000.00, 'Aprobado',  '2024-07-01');

INSERT INTO resenas (Pedido_id, Producto_id, Usuario_id, calificacion, comentario, fecha) VALUES
( 1,  1,  1, 5, 'La nevera es enorme y muy silenciosa, el dispensador de agua es excelente.',    '2024-01-20'),
( 1,  2,  1, 5, 'La lavadora LG lava perfecto y el ciclo rápido es muy útil en el día a día.',  '2024-01-20'),
( 2,  4,  2, 4, 'La estufa es muy buena, el horno integrado calienta parejo y rápido.',         '2024-01-24'),
( 2,  5,  2, 4, 'El microondas funciona bien, aunque el interior podría ser más grande.',        '2024-01-24'),
( 3,  7,  3, 5, 'El aire acondicionado enfría muy rápido y el modo inverter ahorra bastante.',  '2024-01-30'),
( 4,  9,  4, 4, 'La licuadora es potente, tritura hielo sin problema.',                          '2024-02-14'),
( 4, 10,  4, 5, 'La freidora de aire es increíble, las papas quedan crujientes sin aceite.',    '2024-02-14'),
( 4, 11,  4, 5, 'El café de la Nespresso es espectacular, vale cada peso.',                     '2024-02-14'),
( 5, 14,  5, 5, 'El televisor QLED tiene una imagen impresionante, los colores son vivos.',     '2024-02-20'),
( 5, 15,  5, 4, 'La barra de sonido mejora mucho el audio del televisor, buen complemento.',   '2024-02-20'),
( 6,  3,  6, 4, 'El congelador tiene buen espacio y mantiene muy bien la temperatura.',         '2024-02-27'),
( 6, 12,  6, 5, 'La lavadora Whirlpool es silenciosa y el ciclo de 30 min es genial.',         '2024-02-27'),
( 7, 13,  7, 3, 'La plancha funciona bien pero el golpe de vapor podría ser más fuerte.',       '2024-03-10'),
( 8, 17,  8, 5, 'El secador Dyson es increíble, el cabello queda perfecto y sin frizz.',       '2024-03-19'),
( 9, 18,  9, 5, 'El robot aspirador mapea toda la casa solo, una maravilla de tecnología.',    '2024-04-01'),
( 9, 19,  9, 5, 'La aspiradora Dyson V15 succiona todo, el sensor láser es fascinante.',       '2024-04-01'),
(10, 20, 10, 5, 'La KitchenAid es un lujo, hace tortas, pan y pasta sin esfuerzo.',            '2024-04-15'),
(10,  6, 10, 4, 'El horno Haceb es muy completo, la convección hace diferencia al hornear.',   '2024-04-15'),
(15,  7, 15, 5, 'Segundo aire acondicionado que compro de esta marca, nunca falla.',           '2024-05-30'),
(20, 20, 20, 5, 'La batidora KitchenAid llegó perfectamente empacada, funciona excelente.',    '2024-07-08');
 

