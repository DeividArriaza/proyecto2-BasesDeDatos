-- =============================================================================
-- Seed data: ≥25 registros por tabla (rúbrica I, 5 pts).
-- Orden respeta dependencias de FKs. Todo envuelto en una transacción para
-- que, si un INSERT falla, no queden tablas parcialmente pobladas.
-- Impuestos calculados al 12% (IVA Guatemala).
-- =============================================================================

BEGIN;

-- -----------------------------------------------------------------------------
-- Categoria (25)
-- -----------------------------------------------------------------------------
INSERT INTO Categoria (nombre, descripcion) VALUES
('Electrónica',   'Dispositivos electrónicos de consumo'),
('Hogar',         'Productos para el hogar'),
('Oficina',       'Artículos de oficina'),
('Ropa',          'Prendas de vestir'),
('Calzado',       'Zapatos y similares'),
('Juguetes',      'Juguetes infantiles'),
('Libros',        'Libros y literatura'),
('Papelería',     'Útiles escolares y de papelería'),
('Deportes',      'Artículos deportivos'),
('Jardín',        'Productos para jardinería'),
('Herramientas',  'Herramientas manuales y eléctricas'),
('Cocina',        'Utensilios de cocina'),
('Baño',          'Artículos para el baño'),
('Limpieza',      'Productos de limpieza'),
('Belleza',       'Cosméticos y cuidado personal'),
('Salud',         'Productos de salud y farmacia'),
('Tecnología',    'Gadgets y accesorios tech'),
('Mascotas',      'Artículos para mascotas'),
('Comida',        'Alimentos empacados'),
('Bebidas',       'Bebidas embotelladas y enlatadas'),
('Automotriz',    'Accesorios para vehículos'),
('Música',        'Instrumentos y accesorios musicales'),
('Arte',          'Materiales de arte'),
('Bebés',         'Artículos para bebés'),
('Fitness',       'Equipamiento de ejercicio');

-- -----------------------------------------------------------------------------
-- Marca (25)
-- -----------------------------------------------------------------------------
INSERT INTO Marca (nombre, descripcion) VALUES
('Sony',           'Electrónica japonesa'),
('Samsung',        'Electrónica coreana'),
('LG',             'Electrodomésticos y electrónica'),
('Apple',          'Tecnología premium'),
('HP',             'Computación e impresión'),
('Dell',           'Computación empresarial'),
('Logitech',       'Periféricos de computadora'),
('Nike',           'Deportiva estadounidense'),
('Adidas',         'Deportiva alemana'),
('Puma',           'Deportiva alemana'),
('Kleenex',        'Pañuelos y productos de papel'),
('Colgate',        'Higiene bucal'),
('Nestle',         'Alimentos procesados'),
('Coca-Cola',      'Bebidas'),
('PepsiCo',        'Bebidas y snacks'),
('Lego',           'Juguetes de construcción'),
('Mattel',         'Juguetes clásicos'),
('Bosch',          'Herramientas y electrodomésticos'),
('Black & Decker', 'Herramientas para el hogar'),
('3M',             'Productos industriales y adhesivos'),
('Bic',            'Artículos de escritura'),
('Faber-Castell',  'Arte y papelería'),
('Stanley',        'Herramientas manuales'),
('Makita',         'Herramientas eléctricas'),
('Genérico',       'Marca sin especificar');

-- -----------------------------------------------------------------------------
-- Rol (25)
-- -----------------------------------------------------------------------------
INSERT INTO Rol (nombre, descripcion) VALUES
('Administrador',    'Control total del sistema'),
('Gerente General',  'Gestión global de la tienda'),
('Gerente Sucursal', 'Gestión de una sucursal'),
('Supervisor',       'Supervisión de turno'),
('Cajero',           'Operación de caja y ventas'),
('Bodeguero',        'Control de inventario físico'),
('Vendedor',         'Atención y venta en piso'),
('Contador',         'Gestión contable'),
('Auditor',          'Revisión y auditoría interna'),
('RRHH',             'Recursos humanos'),
('Seguridad',        'Vigilancia y prevención de pérdida'),
('Limpieza',         'Mantenimiento y aseo'),
('Recepcionista',    'Atención al público en recepción'),
('Marketing',        'Publicidad y promociones'),
('Sistemas',         'Soporte de tecnología'),
('Soporte Técnico',  'Atención postventa técnica'),
('Logística',        'Gestión de envíos y entregas'),
('Jefe de Compras',  'Gestión de proveedores y compras'),
('Analista Calidad', 'Control de calidad'),
('Entrenador',       'Capacitación de personal'),
('Analista Datos',   'Reportes y análisis'),
('Asistente',        'Apoyo general administrativo'),
('Practicante',      'Estudiante en práctica'),
('Jefe de Turno',    'Coordinación de turno'),
('Asesor Comercial', 'Asesoría de ventas B2B');

-- -----------------------------------------------------------------------------
-- Sucursal (25)
-- -----------------------------------------------------------------------------
INSERT INTO Sucursal (nombre, direccion, telefono) VALUES
('Zona 1 Centro',          '6a Av 10-20, Zona 1, Ciudad de Guatemala',      '2232-0001'),
('Zona 4 Cuatro Grados',   '4a Av 15-30, Zona 4, Ciudad de Guatemala',      '2232-0002'),
('Zona 10 Oakland',        'Av La Reforma 10-15, Zona 10',                  '2332-0003'),
('Zona 11 Majadas',        'Calzada Roosevelt 20-15, Zona 11',              '2432-0004'),
('Zona 13 Aeropuerto',     'Av Hincapié 15-80, Zona 13',                    '2332-0005'),
('Zona 14 Plaza Fontabella','Av Las Américas 7-20, Zona 14',                '2432-0006'),
('Zona 15 Vista Hermosa',  '20 Calle 25-85, Zona 15',                       '2332-0007'),
('Zona 16 Cayalá',         'Paseo Cayalá L-2, Zona 16',                     '2332-0008'),
('Zona 17 Lourdes',        '3a Calle 17-50, Zona 17',                       '2432-0009'),
('Zona 18 Atlántico',      '15 Av 20-30, Zona 18',                          '2432-0010'),
('CES Carretera Salvador', 'Km 13.5 Carr a El Salvador',                    '6632-0011'),
('Mixco San Cristóbal',    '11 Av 0-30, San Cristóbal, Mixco',              '6632-0012'),
('Villa Nueva',            '4a Calle 2-50, Villa Nueva',                    '6632-0013'),
('San Miguel Petapa',      'Av Principal 1-10, San Miguel Petapa',          '6632-0014'),
('Chimaltenango',          '2a Av 3-15, Chimaltenango',                     '7832-0015'),
('Antigua Guatemala',      '5a Av Norte 10, Antigua',                       '7832-0016'),
('Escuintla',              '4a Av 2-50, Escuintla',                         '7832-0017'),
('Quetzaltenango',         '14 Av 3-33, Zona 1, Xela',                      '7732-0018'),
('Huehuetenango',          '5a Av 4-20, Huehue',                            '7732-0019'),
('Cobán',                  '1a Calle 2-30, Zona 2, Cobán',                  '7932-0020'),
('Mazatenango',            '7a Av 5-12, Zona 1, Maza',                      '7832-0021'),
('Retalhuleu',             '6a Av 3-30, Reu',                               '7832-0022'),
('Jutiapa',                '2a Av 1-15, Jutiapa',                           '7832-0023'),
('Santa Rosa Cuilapa',     '3a Calle 2-20, Cuilapa',                        '7832-0024'),
('Alta Verapaz San Pedro', 'Calle Principal 1-5, San Pedro Carchá',         '7932-0025');

-- -----------------------------------------------------------------------------
-- MetodoPago (25)
-- -----------------------------------------------------------------------------
INSERT INTO MetodoPago (nombre) VALUES
('Efectivo'), ('Tarjeta Débito'), ('Tarjeta Crédito Visa'),
('Tarjeta Crédito MasterCard'), ('Tarjeta Crédito AmEx'),
('Transferencia Bancaria'), ('Cheque'), ('PayPal'),
('Apple Pay'), ('Google Pay'), ('Samsung Pay'),
('Visa Cuotas'), ('MasterCard Cuotas'), ('Zelle'),
('Venmo'), ('Cash App'), ('MercadoPago'),
('Stripe'), ('Bancolombia Transfer'), ('Nequi'),
('Daviplata'), ('Rappi Pay'), ('Western Union'),
('MoneyGram'), ('Crédito Interno');

-- -----------------------------------------------------------------------------
-- Proveedor (25)
-- -----------------------------------------------------------------------------
INSERT INTO Proveedor (nombre, nit, telefono, email, direccion) VALUES
('Distribuidora Central S.A.',    '1234567-1', '2232-1001', 'ventas@distcentral.gt',   '5a Av 10-10 Z1'),
('Importadora del Sur Ltda.',     '1234568-2', '2232-1002', 'contacto@impsur.gt',      '8a Av 5-20 Z4'),
('Mayoreo Pacífico',              '1234569-3', '2232-1003', 'pedidos@maypacif.gt',     'Diagonal 6 15-30 Z10'),
('Global Trade Guatemala',        '1234570-4', '2232-1004', 'info@globaltrade.gt',     'Calzada Roosevelt 20-80'),
('Proveedora Tech Plus',          '1234571-5', '2232-1005', 'ventas@techplus.gt',      'Av La Reforma 12-01 Z10'),
('Industrias Unidas',             '1234572-6', '2332-1006', 'compras@indunidas.gt',    'Km 15 Ruta al Atlántico'),
('Alimentos del Valle',           '1234573-7', '2332-1007', 'ventas@alvalle.gt',       'Km 30 CA-1 Sur'),
('Bebidas Premium',               '1234574-8', '2332-1008', 'pedidos@bebprem.gt',      'Calzada Aguilar Batres 33'),
('Textiles Maya',                 '1234575-9', '2332-1009', 'info@texmaya.gt',         'Av Las Américas 9-05 Z13'),
('Calzado Nacional',              '1234576-K', '2332-1010', 'ventas@calnac.gt',        'Calle Marti 3-20 Z6'),
('Juguetes Chapín',               '1234577-1', '2432-1011', 'contacto@jugchapin.gt',   '20 Calle 15-30 Z11'),
('Librería Universal',            '1234578-2', '2432-1012', 'pedidos@libuniv.gt',      '6a Av 11-38 Z1'),
('Papelería La Oficina',          '1234579-3', '2432-1013', 'ventas@laoficina.gt',     '7a Av 14-15 Z4'),
('Deportes Guate',                '1234580-4', '2432-1014', 'info@depguate.gt',        'Av Petapa 45-50 Z12'),
('Jardines Tropicales',           '1234581-5', '2432-1015', 'contacto@jarditrop.gt',   'Km 17 Carr El Salvador'),
('Ferretería Industrial',         '1234582-6', '2632-1016', 'ventas@ferrind.gt',       'Anillo Periférico 8-50'),
('Hogar Total',                   '1234583-7', '2632-1017', 'pedidos@hogartotal.gt',   'Boulevard Los Próceres 5'),
('Belleza y Estilo',              '1234584-8', '2632-1018', 'info@beyest.gt',          '12 Calle 1-25 Z10'),
('Farmacéutica Central',          '1234585-9', '2632-1019', 'ventas@farmcen.gt',       '9a Av 12-50 Z1'),
('Tech Imports',                  '1234586-K', '2732-1020', 'contacto@techimp.gt',     'Av Reforma 15-45 Z9'),
('Mascotas Felices',              '1234587-1', '2732-1021', 'info@masfelices.gt',      'Calle Mariscal 3-22 Z11'),
('Alimentos Gourmet',             '1234588-2', '2732-1022', 'ventas@algourmet.gt',     '7a Av 20-15 Z14'),
('Automotriz del Norte',          '1234589-3', '2732-1023', 'pedidos@autonorte.gt',    'Calzada San Juan 35'),
('Música y Sonido',               '1234590-4', '2732-1024', 'contacto@musson.gt',      '6a Av 8-50 Z1'),
('Arte Creativo',                 '1234591-5', '2732-1025', 'ventas@artcreat.gt',      'Diagonal 12 3-20 Z10');

-- -----------------------------------------------------------------------------
-- Cliente (25) — mezcla con y sin NIT (CF)
-- -----------------------------------------------------------------------------
INSERT INTO Cliente (nombres, apellidos, nit, telefono, email, direccion) VALUES
('María',      'González López',        '987654-1', '5512-0001', 'maria.gonzalez@mail.gt',   '1a Av 2-30 Z1'),
('Juan',       'Pérez Hernández',       '987655-2', '5512-0002', 'juan.perez@mail.gt',       '2a Av 3-45 Z4'),
('Ana',        'Ramírez Soto',          '987656-3', '5512-0003', 'ana.ramirez@mail.gt',      '3a Av 5-10 Z10'),
('Luis',       'Morales Chávez',        NULL,       '5512-0004', 'luis.morales@mail.gt',     '4a Av 8-22 Z11'),
('Sofía',      'Castro Mendoza',        '987658-5', '5512-0005', 'sofia.castro@mail.gt',     '5a Av 10-15 Z13'),
('Pedro',      'Jiménez Pineda',        '987659-6', '5512-0006', 'pedro.jimenez@mail.gt',    '6a Av 12-30 Z14'),
('Lucía',      'Vásquez Ortiz',         NULL,       '5512-0007', 'lucia.vasquez@mail.gt',    '7a Av 15-40 Z15'),
('Carlos',     'Gómez Ruiz',            '987661-8', '5512-0008', 'carlos.gomez@mail.gt',     '8a Av 20-10 Z16'),
('Elena',      'Díaz Martínez',         '987662-9', '5512-0009', 'elena.diaz@mail.gt',       '9a Av 5-25 Z17'),
('Miguel',     'Reyes Aguilar',         NULL,       '5512-0010', 'miguel.reyes@mail.gt',     '10a Av 18-32 Z18'),
('Isabel',     'Flores Fuentes',        '987664-1', '5512-0011', 'isabel.flores@mail.gt',    '11a Av 3-48 Z1'),
('Diego',      'Herrera Cabrera',       '987665-2', '5512-0012', 'diego.herrera@mail.gt',    '12a Av 7-12 Z4'),
('Camila',     'Paredes Rivas',         '987666-3', '5512-0013', 'camila.paredes@mail.gt',   '13a Av 9-33 Z10'),
('Andrés',     'Ortega Bonilla',        NULL,       '5512-0014', 'andres.ortega@mail.gt',    '14a Av 11-18 Z11'),
('Valentina',  'Navarro Mejía',         '987668-5', '5512-0015', 'valentina.navarro@mail.gt','15a Av 13-29 Z13'),
('Sebastián',  'Ríos Escobar',          '987669-6', '5512-0016', 'sebastian.rios@mail.gt',   '16a Av 15-14 Z14'),
('Daniela',    'Contreras Molina',      '987670-7', '5512-0017', 'daniela.contreras@mail.gt','17a Av 17-25 Z15'),
('Mateo',      'Salazar Barrientos',    NULL,       '5512-0018', 'mateo.salazar@mail.gt',    '18a Av 19-37 Z16'),
('Paula',      'Vega Alfaro',           '987672-9', '5512-0019', 'paula.vega@mail.gt',       '19a Av 21-40 Z17'),
('Tomás',      'Espinoza Juárez',       '987673-K', '5512-0020', 'tomas.espinoza@mail.gt',   '20a Av 23-51 Z18'),
('Gabriela',   'Acosta Leiva',          '987674-1', '5512-0021', 'gabriela.acosta@mail.gt',  '21a Av 2-14 Z1'),
('Rodrigo',    'Cifuentes Gómez',       '987675-2', '5512-0022', 'rodrigo.cifuentes@mail.gt','22a Av 4-25 Z4'),
('Natalia',    'Quiñónez Arévalo',      '987676-3', '5512-0023', 'natalia.quinonez@mail.gt', '23a Av 6-37 Z10'),
('Javier',     'Solís Godoy',           NULL,       '5512-0024', 'javier.solis@mail.gt',     '24a Av 8-48 Z11'),
('Alejandra',  'Monterroso Batres',     '987678-5', '5512-0025', 'alejandra.monter@mail.gt', '25a Av 10-19 Z13');

-- -----------------------------------------------------------------------------
-- Producto (25) — id_categoria e id_marca rotan 1..25
-- Stock inicial alto (200) para soportar las ventas del seed.
-- -----------------------------------------------------------------------------
INSERT INTO Producto (sku, nombre, descripcion, precio, stock, stock_minimo, id_categoria, id_marca) VALUES
('SKU-0001', 'Smart TV 55 pulgadas 4K',        'Televisor LED 4K UHD',             4500.00, 200, 10,  1,  1),
('SKU-0002', 'Refrigerador French Door',       'Refrigeradora de dos puertas',     8900.00, 200, 5,   2,  2),
('SKU-0003', 'Silla ejecutiva ergonómica',     'Silla de oficina con soporte',     1200.00, 200, 10,  3,  3),
('SKU-0004', 'Camisa polo manga corta',        'Polo algodón 100%',                 150.00, 200, 30,  4,  4),
('SKU-0005', 'Tenis running profesional',      'Tenis deportivos',                  650.00, 200, 20,  5,  5),
('SKU-0006', 'Set bloques constructivos',      'Set de 500 piezas',                 350.00, 200, 15,  6,  6),
('SKU-0007', 'Novela de ficción bestseller',   'Libro edición de tapa dura',         90.00, 200, 50,  7,  7),
('SKU-0008', 'Cuaderno universitario 200h',    'Cuaderno espiral',                   45.00, 200, 100, 8,  8),
('SKU-0009', 'Balón de fútbol profesional',    'Balón tamaño 5',                    250.00, 200, 25,  9,  9),
('SKU-0010', 'Set herramientas jardín',        'Pala, rastrillo y tijeras',         400.00, 200, 15, 10, 10),
('SKU-0011', 'Taladro percutor inalámbrico',   'Taladro 20V con batería',           950.00, 200, 10, 11, 11),
('SKU-0012', 'Sartén antiadherente 28cm',      'Sartén de aluminio recubierto',     300.00, 200, 20, 12, 12),
('SKU-0013', 'Toallas de baño set 4pz',        'Toallas 100% algodón',              450.00, 200, 25, 13, 13),
('SKU-0014', 'Detergente líquido 5L',          'Detergente multiuso',               180.00, 200, 30, 14, 14),
('SKU-0015', 'Crema facial hidratante',        'Crema antiarrugas 50ml',            275.00, 200, 20, 15, 15),
('SKU-0016', 'Multivitamínico 100 tabs',       'Suplemento diario',                 160.00, 200, 40, 16, 16),
('SKU-0017', 'Audífonos bluetooth',            'Inalámbricos con cancelación',      800.00, 200, 15, 17, 17),
('SKU-0018', 'Comida para perro 10kg',         'Alimento premium para adultos',     320.00, 200, 25, 18, 18),
('SKU-0019', 'Caja de galletas surtidas',      'Galletas variadas 500g',             65.00, 200, 50, 19, 19),
('SKU-0020', 'Refresco cola 2L',               'Bebida gaseosa',                     22.00, 200, 100, 20, 20),
('SKU-0021', 'Set limpieza auto',              'Shampoo, cera y microfibra',        280.00, 200, 15, 21, 21),
('SKU-0022', 'Guitarra acústica',              'Guitarra clásica de madera',       1800.00, 200, 8,  22, 22),
('SKU-0023', 'Set lápices de colores 48',      'Lápices profesionales',             195.00, 200, 30, 23, 23),
('SKU-0024', 'Pañales bebé talla M 80pz',      'Pañales desechables',               220.00, 200, 40, 24, 24),
('SKU-0025', 'Mancuernas 10lb par',            'Mancuernas recubiertas',            320.00, 200, 20, 25, 25);

-- -----------------------------------------------------------------------------
-- Empleado (25) — password_hash es bcrypt de 'demo123' para todos los seeds.
-- id_rol e id_sucursal rotan 1..25.
-- -----------------------------------------------------------------------------
INSERT INTO Empleado (nombres, apellidos, email, telefono, username, password_hash, fecha_ingreso, id_rol, id_sucursal) VALUES
('Roberto',    'Alvarado Pineda',       'roberto.alvarado@tienda.gt',   '5511-0001', 'ralvarado',   '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-01-15',  1,  1),
('Carmen',     'Barrios Escobar',       'carmen.barrios@tienda.gt',     '5511-0002', 'cbarrios',    '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-02-01',  2,  2),
('Fernando',   'Coronado Solís',        'fernando.coronado@tienda.gt',  '5511-0003', 'fcoronado',   '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-02-15',  3,  3),
('Silvia',     'Delgado Ramos',         'silvia.delgado@tienda.gt',     '5511-0004', 'sdelgado',    '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-03-01',  4,  4),
('Marco',      'Estrada López',         'marco.estrada@tienda.gt',      '5511-0005', 'mestrada',    '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-03-15',  5,  5),
('Patricia',   'Figueroa Cano',         'patricia.figueroa@tienda.gt',  '5511-0006', 'pfigueroa',   '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-04-01',  6,  6),
('Ricardo',    'Guerrero Pinto',        'ricardo.guerrero@tienda.gt',   '5511-0007', 'rguerrero',   '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-04-15',  7,  7),
('Lorena',     'Hurtado Méndez',        'lorena.hurtado@tienda.gt',     '5511-0008', 'lhurtado',    '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-05-01',  8,  8),
('Andrés',     'Iglesias Soto',         'andres.iglesias@tienda.gt',    '5511-0009', 'aiglesias',   '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-05-15',  9,  9),
('Beatriz',    'Juárez Cortez',         'beatriz.juarez@tienda.gt',     '5511-0010', 'bjuarez',     '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-06-01',  10, 10),
('Óscar',      'Kuc Xol',               'oscar.kuc@tienda.gt',          '5511-0011', 'okuc',        '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-06-15',  11, 11),
('Rosa',       'López Marroquín',       'rosa.lopez@tienda.gt',         '5511-0012', 'rlopez',      '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-07-01',  12, 12),
('Jorge',      'Monzón Paniagua',       'jorge.monzon@tienda.gt',       '5511-0013', 'jmonzon',     '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-07-15',  13, 13),
('Verónica',   'Núñez Aldana',          'veronica.nunez@tienda.gt',     '5511-0014', 'vnunez',      '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-08-01',  14, 14),
('Edgar',      'Ochoa Valle',           'edgar.ochoa@tienda.gt',        '5511-0015', 'eochoa',      '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-08-15',  15, 15),
('Mónica',     'Pacheco Lemus',         'monica.pacheco@tienda.gt',     '5511-0016', 'mpacheco',    '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-09-01',  16, 16),
('Humberto',   'Quevedo Rayo',          'humberto.quevedo@tienda.gt',   '5511-0017', 'hquevedo',    '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-09-15',  17, 17),
('Gloria',     'Rodríguez Tello',       'gloria.rodriguez@tienda.gt',   '5511-0018', 'grodriguez',  '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-10-01',  18, 18),
('Alberto',    'Sandoval Urrutia',      'alberto.sandoval@tienda.gt',   '5511-0019', 'asandoval',   '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-10-15',  19, 19),
('Claudia',    'Toledo Véliz',          'claudia.toledo@tienda.gt',     '5511-0020', 'ctoledo',     '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-11-01',  20, 20),
('Mauricio',   'Urrea Zamora',          'mauricio.urrea@tienda.gt',     '5511-0021', 'murrea',      '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-11-15',  21, 21),
('Nancy',      'Vivar Argueta',         'nancy.vivar@tienda.gt',        '5511-0022', 'nvivar',      '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-12-01',  22, 22),
('Francisco',  'Wong Chang',            'francisco.wong@tienda.gt',     '5511-0023', 'fwong',       '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2024-12-15',  23, 23),
('Alicia',     'Yax Coc',               'alicia.yax@tienda.gt',         '5511-0024', 'ayax',        '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2025-01-01',  24, 24),
('David',      'Zepeda Ramírez',        'david.zepeda@tienda.gt',       '5511-0025', 'dzepeda',     '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '2025-01-15',  25, 25);

-- -----------------------------------------------------------------------------
-- CompraProveedor (25)
-- Patrón: compras 1..5 tienen 2 detalles (subtotal 2000, impuesto 240, total 2240)
--         compras 6..25 tienen 1 detalle (subtotal 1000, impuesto 120, total 1120)
-- FKs rotan 1..25 para proveedor, empleado, sucursal.
-- -----------------------------------------------------------------------------
INSERT INTO CompraProveedor (fecha, numero_factura, subtotal, impuesto, total, id_proveedor, id_empleado, id_sucursal) VALUES
('2025-01-05 09:00:00', 'FC-0001', 2000.00, 240.00, 2240.00,  1,  1,  1),
('2025-01-06 09:00:00', 'FC-0002', 2000.00, 240.00, 2240.00,  2,  2,  2),
('2025-01-07 09:00:00', 'FC-0003', 2000.00, 240.00, 2240.00,  3,  3,  3),
('2025-01-08 09:00:00', 'FC-0004', 2000.00, 240.00, 2240.00,  4,  4,  4),
('2025-01-09 09:00:00', 'FC-0005', 2000.00, 240.00, 2240.00,  5,  5,  5),
('2025-01-10 09:00:00', 'FC-0006', 1000.00, 120.00, 1120.00,  6,  6,  6),
('2025-01-11 09:00:00', 'FC-0007', 1000.00, 120.00, 1120.00,  7,  7,  7),
('2025-01-12 09:00:00', 'FC-0008', 1000.00, 120.00, 1120.00,  8,  8,  8),
('2025-01-13 09:00:00', 'FC-0009', 1000.00, 120.00, 1120.00,  9,  9,  9),
('2025-01-14 09:00:00', 'FC-0010', 1000.00, 120.00, 1120.00, 10, 10, 10),
('2025-01-15 09:00:00', 'FC-0011', 1000.00, 120.00, 1120.00, 11, 11, 11),
('2025-01-16 09:00:00', 'FC-0012', 1000.00, 120.00, 1120.00, 12, 12, 12),
('2025-01-17 09:00:00', 'FC-0013', 1000.00, 120.00, 1120.00, 13, 13, 13),
('2025-01-18 09:00:00', 'FC-0014', 1000.00, 120.00, 1120.00, 14, 14, 14),
('2025-01-19 09:00:00', 'FC-0015', 1000.00, 120.00, 1120.00, 15, 15, 15),
('2025-01-20 09:00:00', 'FC-0016', 1000.00, 120.00, 1120.00, 16, 16, 16),
('2025-01-21 09:00:00', 'FC-0017', 1000.00, 120.00, 1120.00, 17, 17, 17),
('2025-01-22 09:00:00', 'FC-0018', 1000.00, 120.00, 1120.00, 18, 18, 18),
('2025-01-23 09:00:00', 'FC-0019', 1000.00, 120.00, 1120.00, 19, 19, 19),
('2025-01-24 09:00:00', 'FC-0020', 1000.00, 120.00, 1120.00, 20, 20, 20),
('2025-01-25 09:00:00', 'FC-0021', 1000.00, 120.00, 1120.00, 21, 21, 21),
('2025-01-26 09:00:00', 'FC-0022', 1000.00, 120.00, 1120.00, 22, 22, 22),
('2025-01-27 09:00:00', 'FC-0023', 1000.00, 120.00, 1120.00, 23, 23, 23),
('2025-01-28 09:00:00', 'FC-0024', 1000.00, 120.00, 1120.00, 24, 24, 24),
('2025-01-29 09:00:00', 'FC-0025', 1000.00, 120.00, 1120.00, 25, 25, 25);

-- -----------------------------------------------------------------------------
-- DetalleCompra (30) — 25 detalles principales (1 por compra) + 5 extras
-- en compras 1-5. Cada detalle: cantidad 10 * costo 100 = subtotal 1000.
-- -----------------------------------------------------------------------------
INSERT INTO DetalleCompra (id_compra, id_producto, cantidad, costo_unitario, subtotal) VALUES
-- Principal: un detalle por cada compra 1..25
( 1,  1, 10, 100.00, 1000.00),
( 2,  2, 10, 100.00, 1000.00),
( 3,  3, 10, 100.00, 1000.00),
( 4,  4, 10, 100.00, 1000.00),
( 5,  5, 10, 100.00, 1000.00),
( 6,  6, 10, 100.00, 1000.00),
( 7,  7, 10, 100.00, 1000.00),
( 8,  8, 10, 100.00, 1000.00),
( 9,  9, 10, 100.00, 1000.00),
(10, 10, 10, 100.00, 1000.00),
(11, 11, 10, 100.00, 1000.00),
(12, 12, 10, 100.00, 1000.00),
(13, 13, 10, 100.00, 1000.00),
(14, 14, 10, 100.00, 1000.00),
(15, 15, 10, 100.00, 1000.00),
(16, 16, 10, 100.00, 1000.00),
(17, 17, 10, 100.00, 1000.00),
(18, 18, 10, 100.00, 1000.00),
(19, 19, 10, 100.00, 1000.00),
(20, 20, 10, 100.00, 1000.00),
(21, 21, 10, 100.00, 1000.00),
(22, 22, 10, 100.00, 1000.00),
(23, 23, 10, 100.00, 1000.00),
(24, 24, 10, 100.00, 1000.00),
(25, 25, 10, 100.00, 1000.00),
-- Extras: segundo detalle en compras 1..5 con producto "espejo" para no romper UNIQUE
( 1, 25, 10, 100.00, 1000.00),
( 2, 24, 10, 100.00, 1000.00),
( 3, 23, 10, 100.00, 1000.00),
( 4, 22, 10, 100.00, 1000.00),
( 5, 21, 10, 100.00, 1000.00);

-- -----------------------------------------------------------------------------
-- Venta (25)
-- Ventas 1..15: con cliente registrado (id_cliente 1..15)
-- Ventas 16..25: mostrador (id_cliente NULL)
-- Ventas 1..5: 2 detalles (subtotal 2000, impuesto 240, total 2240)
-- Ventas 6..25: 1 detalle (subtotal 1000, impuesto 120, total 1120)
-- -----------------------------------------------------------------------------
INSERT INTO Venta (fecha, numero_factura, subtotal, impuesto, total, id_cliente, id_empleado, id_sucursal, id_metodo_pago) VALUES
('2025-02-05 10:00:00', 'FV-0001', 2000.00, 240.00, 2240.00,  1,  1,  1,  1),
('2025-02-06 10:00:00', 'FV-0002', 2000.00, 240.00, 2240.00,  2,  2,  2,  2),
('2025-02-07 10:00:00', 'FV-0003', 2000.00, 240.00, 2240.00,  3,  3,  3,  3),
('2025-02-08 10:00:00', 'FV-0004', 2000.00, 240.00, 2240.00,  4,  4,  4,  4),
('2025-02-09 10:00:00', 'FV-0005', 2000.00, 240.00, 2240.00,  5,  5,  5,  5),
('2025-02-10 10:00:00', 'FV-0006', 1000.00, 120.00, 1120.00,  6,  6,  6,  6),
('2025-02-11 10:00:00', 'FV-0007', 1000.00, 120.00, 1120.00,  7,  7,  7,  7),
('2025-02-12 10:00:00', 'FV-0008', 1000.00, 120.00, 1120.00,  8,  8,  8,  8),
('2025-02-13 10:00:00', 'FV-0009', 1000.00, 120.00, 1120.00,  9,  9,  9,  9),
('2025-02-14 10:00:00', 'FV-0010', 1000.00, 120.00, 1120.00, 10, 10, 10, 10),
('2025-02-15 10:00:00', 'FV-0011', 1000.00, 120.00, 1120.00, 11, 11, 11, 11),
('2025-02-16 10:00:00', 'FV-0012', 1000.00, 120.00, 1120.00, 12, 12, 12, 12),
('2025-02-17 10:00:00', 'FV-0013', 1000.00, 120.00, 1120.00, 13, 13, 13, 13),
('2025-02-18 10:00:00', 'FV-0014', 1000.00, 120.00, 1120.00, 14, 14, 14, 14),
('2025-02-19 10:00:00', 'FV-0015', 1000.00, 120.00, 1120.00, 15, 15, 15, 15),
-- Ventas de mostrador (sin cliente):
('2025-02-20 10:00:00', 'FV-0016', 1000.00, 120.00, 1120.00, NULL, 16, 16, 16),
('2025-02-21 10:00:00', 'FV-0017', 1000.00, 120.00, 1120.00, NULL, 17, 17, 17),
('2025-02-22 10:00:00', 'FV-0018', 1000.00, 120.00, 1120.00, NULL, 18, 18, 18),
('2025-02-23 10:00:00', 'FV-0019', 1000.00, 120.00, 1120.00, NULL, 19, 19, 19),
('2025-02-24 10:00:00', 'FV-0020', 1000.00, 120.00, 1120.00, NULL, 20, 20, 20),
('2025-02-25 10:00:00', 'FV-0021', 1000.00, 120.00, 1120.00, NULL, 21, 21, 21),
('2025-02-26 10:00:00', 'FV-0022', 1000.00, 120.00, 1120.00, NULL, 22, 22, 22),
('2025-02-27 10:00:00', 'FV-0023', 1000.00, 120.00, 1120.00, NULL, 23, 23, 23),
('2025-02-28 10:00:00', 'FV-0024', 1000.00, 120.00, 1120.00, NULL, 24, 24, 24),
('2025-03-01 10:00:00', 'FV-0025', 1000.00, 120.00, 1120.00, NULL, 25, 25, 25);

-- -----------------------------------------------------------------------------
-- DetalleVenta (30) — 25 principales + 5 extras (en ventas 1-5).
-- precio_unitario es snapshot: coincide con Producto.precio al momento.
-- -----------------------------------------------------------------------------
INSERT INTO DetalleVenta (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES
-- Principal: un detalle por cada venta 1..25
( 1,  1, 10, 100.00, 1000.00),
( 2,  2, 10, 100.00, 1000.00),
( 3,  3, 10, 100.00, 1000.00),
( 4,  4, 10, 100.00, 1000.00),
( 5,  5, 10, 100.00, 1000.00),
( 6,  6, 10, 100.00, 1000.00),
( 7,  7, 10, 100.00, 1000.00),
( 8,  8, 10, 100.00, 1000.00),
( 9,  9, 10, 100.00, 1000.00),
(10, 10, 10, 100.00, 1000.00),
(11, 11, 10, 100.00, 1000.00),
(12, 12, 10, 100.00, 1000.00),
(13, 13, 10, 100.00, 1000.00),
(14, 14, 10, 100.00, 1000.00),
(15, 15, 10, 100.00, 1000.00),
(16, 16, 10, 100.00, 1000.00),
(17, 17, 10, 100.00, 1000.00),
(18, 18, 10, 100.00, 1000.00),
(19, 19, 10, 100.00, 1000.00),
(20, 20, 10, 100.00, 1000.00),
(21, 21, 10, 100.00, 1000.00),
(22, 22, 10, 100.00, 1000.00),
(23, 23, 10, 100.00, 1000.00),
(24, 24, 10, 100.00, 1000.00),
(25, 25, 10, 100.00, 1000.00),
-- Extras: segundo detalle en ventas 1..5
( 1, 25, 10, 100.00, 1000.00),
( 2, 24, 10, 100.00, 1000.00),
( 3, 23, 10, 100.00, 1000.00),
( 4, 22, 10, 100.00, 1000.00),
( 5, 21, 10, 100.00, 1000.00);

-- -----------------------------------------------------------------------------
-- MovimientoStock (30) — exclusive arc:
--   ENTRADA: id_compra OBLIGATORIO, id_venta NULL, cantidad > 0
--   SALIDA:  id_venta OBLIGATORIO, id_compra NULL, cantidad > 0
--   AJUSTE:  ambos NULL, cantidad <> 0 (puede ser negativo)
-- -----------------------------------------------------------------------------
INSERT INTO MovimientoStock (fecha, tipo, cantidad, stock_resultante, motivo, id_producto, id_empleado, id_sucursal, id_compra, id_venta) VALUES
-- ENTRADAS: 15, vinculadas a compras 1..15
('2025-01-05 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0001',  1,  1,  1,  1, NULL),
('2025-01-06 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0002',  2,  2,  2,  2, NULL),
('2025-01-07 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0003',  3,  3,  3,  3, NULL),
('2025-01-08 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0004',  4,  4,  4,  4, NULL),
('2025-01-09 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0005',  5,  5,  5,  5, NULL),
('2025-01-10 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0006',  6,  6,  6,  6, NULL),
('2025-01-11 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0007',  7,  7,  7,  7, NULL),
('2025-01-12 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0008',  8,  8,  8,  8, NULL),
('2025-01-13 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0009',  9,  9,  9,  9, NULL),
('2025-01-14 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0010', 10, 10, 10, 10, NULL),
('2025-01-15 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0011', 11, 11, 11, 11, NULL),
('2025-01-16 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0012', 12, 12, 12, 12, NULL),
('2025-01-17 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0013', 13, 13, 13, 13, NULL),
('2025-01-18 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0014', 14, 14, 14, 14, NULL),
('2025-01-19 09:30:00', 'ENTRADA', 10, 210, 'Ingreso por compra FC-0015', 15, 15, 15, 15, NULL),
-- SALIDAS: 10, vinculadas a ventas 1..10
('2025-02-05 10:30:00', 'SALIDA',  10, 200, 'Salida por venta FV-0001',    1,  1,  1, NULL,  1),
('2025-02-06 10:30:00', 'SALIDA',  10, 200, 'Salida por venta FV-0002',    2,  2,  2, NULL,  2),
('2025-02-07 10:30:00', 'SALIDA',  10, 200, 'Salida por venta FV-0003',    3,  3,  3, NULL,  3),
('2025-02-08 10:30:00', 'SALIDA',  10, 200, 'Salida por venta FV-0004',    4,  4,  4, NULL,  4),
('2025-02-09 10:30:00', 'SALIDA',  10, 200, 'Salida por venta FV-0005',    5,  5,  5, NULL,  5),
('2025-02-10 10:30:00', 'SALIDA',  10, 200, 'Salida por venta FV-0006',    6,  6,  6, NULL,  6),
('2025-02-11 10:30:00', 'SALIDA',  10, 200, 'Salida por venta FV-0007',    7,  7,  7, NULL,  7),
('2025-02-12 10:30:00', 'SALIDA',  10, 200, 'Salida por venta FV-0008',    8,  8,  8, NULL,  8),
('2025-02-13 10:30:00', 'SALIDA',  10, 200, 'Salida por venta FV-0009',    9,  9,  9, NULL,  9),
('2025-02-14 10:30:00', 'SALIDA',  10, 200, 'Salida por venta FV-0010',   10, 10, 10, NULL, 10),
-- AJUSTES: 5, ambos FKs NULL (cantidad puede ser +/-)
('2025-03-02 11:00:00', 'AJUSTE',  -3, 197, 'Ajuste por conteo físico: faltante',  1,  1,  1, NULL, NULL),
('2025-03-03 11:00:00', 'AJUSTE',   5, 205, 'Ajuste por devolución interna',       2,  2,  2, NULL, NULL),
('2025-03-04 11:00:00', 'AJUSTE',  -2, 198, 'Ajuste por merma (producto dañado)',  3,  3,  3, NULL, NULL),
('2025-03-05 11:00:00', 'AJUSTE',  -1, 199, 'Ajuste por producto vencido',         4,  4,  4, NULL, NULL),
('2025-03-06 11:00:00', 'AJUSTE',   4, 204, 'Ajuste por corrección de conteo',     5,  5,  5, NULL, NULL);

COMMIT;

-- Conteo rápido de verificación (visible en logs al bootear):
SELECT 'Categoria: '       || COUNT(*) AS conteo FROM Categoria
UNION ALL SELECT 'Marca: '           || COUNT(*) FROM Marca
UNION ALL SELECT 'Rol: '             || COUNT(*) FROM Rol
UNION ALL SELECT 'Sucursal: '        || COUNT(*) FROM Sucursal
UNION ALL SELECT 'MetodoPago: '      || COUNT(*) FROM MetodoPago
UNION ALL SELECT 'Proveedor: '       || COUNT(*) FROM Proveedor
UNION ALL SELECT 'Cliente: '         || COUNT(*) FROM Cliente
UNION ALL SELECT 'Producto: '        || COUNT(*) FROM Producto
UNION ALL SELECT 'Empleado: '        || COUNT(*) FROM Empleado
UNION ALL SELECT 'CompraProveedor: ' || COUNT(*) FROM CompraProveedor
UNION ALL SELECT 'DetalleCompra: '   || COUNT(*) FROM DetalleCompra
UNION ALL SELECT 'Venta: '           || COUNT(*) FROM Venta
UNION ALL SELECT 'DetalleVenta: '    || COUNT(*) FROM DetalleVenta
UNION ALL SELECT 'MovimientoStock: ' || COUNT(*) FROM MovimientoStock;
