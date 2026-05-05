# Universidad del Valle de Guatemala
## Bases de datos 1
## Proyecto 2 — Bubu's Bakery

David López — 24730

---

## Descripción Técnica

### Descripción del sistema y alcance

El sistema propuesto consiste en una aplicación web diseñada para administrar el inventario y las ventas de **Bubu's Bakery**, una repostería boutique guatemalteca especializada en brownies artesanales. Actualmente, muchas reposterías de barrio manejan su inventario con cuadernos físicos o con hojas de cálculo dispersas, lo que dificulta llevar el control real del stock, identificar los productos más vendidos y conocer el comportamiento de las ventas por sucursal.

La plataforma busca centralizar este proceso, permitiendo que la administradora cuente con un único panel desde el cual puede registrar productos, gestionar clientes, registrar ventas con cálculo automático de impuestos, y consultar reportes analíticos sobre el desempeño del negocio. Cada operación de venta se ejecuta dentro de una transacción explícita que actualiza simultáneamente la cabecera de la venta, sus detalles, el stock de los productos involucrados y la bitácora de movimientos de inventario.

Dentro del sistema existe un único tipo de usuario funcional: la **administradora** de la cadena. Sin embargo, la base de datos modela 25 empleados de distintos roles (pasteleros, cajeros, baristas, vendedores, etc.) distribuidos en 25 sucursales, ya que estos registros son referenciados por las ventas y compras como "responsable" o "operador". El acceso a la aplicación se controla mediante autenticación con sesión y contraseñas hasheadas con bcrypt.

El sistema incluye funcionalidades de soporte como el cálculo automático del IVA (12%), generación de número de factura correlativa, validación en línea del stock disponible al momento de registrar una venta, exportación de reportes a CSV y un mecanismo de soft delete para productos y clientes que preserva la integridad referencial del histórico de ventas.

El alcance del sistema se enfoca en la operación diaria del negocio: catálogo de productos, alta/edición/baja de clientes, registro de ventas con detalle, control de stock con bitácora, y reportes para la toma de decisiones. No se contempla en esta versión la gestión de cuentas bancarias, la facturación electrónica con SAT, ni la integración con plataformas de delivery externas.

---

## Identificación formal de entidades y atributos

El modelo está organizado en 6 bloques temáticos que agrupan las 14 entidades del sistema.

### Bloque 1 — Catálogo

- **Categoria**: nombre, descripción.
- **Marca**: nombre, descripción.
- **Producto**: SKU, nombre, descripción, precio, stock, stock mínimo, activo, fecha de creación.

### Bloque 2 — Personas

- **Rol**: nombre, descripción.
- **Empleado**: nombres, apellidos, email, teléfono, username, password hash (bcrypt), activo, fecha de ingreso.
- **Proveedor**: nombre, NIT, teléfono, email, dirección, activo.
- **Cliente**: nombres, apellidos, NIT, teléfono, email, dirección, fecha de registro, activo.

### Bloque 3 — Infraestructura

- **Sucursal**: nombre, dirección, teléfono, activa.
- **MetodoPago**: nombre, activo.

### Bloque 4 — Compras a proveedor

- **CompraProveedor**: fecha, número de factura, subtotal, impuesto, total, estado (COMPLETADA / ANULADA).
- **DetalleCompra**: cantidad, costo unitario, subtotal.

### Bloque 5 — Ventas a cliente

- **Venta**: fecha, número de factura, subtotal, impuesto, total, estado (COMPLETADA / ANULADA).
- **DetalleVenta**: cantidad, precio unitario (snapshot al momento de la venta), subtotal.

### Bloque 6 — Trazabilidad

- **MovimientoStock**: fecha, tipo (ENTRADA / SALIDA / AJUSTE), cantidad, stock resultante, motivo.

---

## Identificación de claves candidatas y clave primaria seleccionada

### Categoria
- Llaves candidatas: id_categoria, nombre.
- Clave primaria seleccionada: **id_categoria**.

### Marca
- Llaves candidatas: id_marca, nombre.
- Clave primaria seleccionada: **id_marca**.

### Producto
- Llaves candidatas: id_producto, sku.
- Clave primaria seleccionada: **id_producto**.

### Rol
- Llaves candidatas: id_rol, nombre.
- Clave primaria seleccionada: **id_rol**.

### Sucursal
- Llaves candidatas: id_sucursal, nombre.
- Clave primaria seleccionada: **id_sucursal**.

### Empleado
- Llaves candidatas: id_empleado, email, username.
- Clave primaria seleccionada: **id_empleado**.

### Proveedor
- Llaves candidatas: id_proveedor, NIT.
- Clave primaria seleccionada: **id_proveedor**.

### Cliente
- Llaves candidatas: id_cliente, NIT.
- Clave primaria seleccionada: **id_cliente** (NIT no aplica como PK porque puede ser NULL en ventas de mostrador / Consumidor Final).

### MetodoPago
- Llaves candidatas: id_metodo_pago, nombre.
- Clave primaria seleccionada: **id_metodo_pago**.

### CompraProveedor
- Llaves candidatas: id_compra.
- Clave primaria seleccionada: **id_compra**.

### DetalleCompra
- Llaves candidatas: id_detalle_compra, (id_compra, id_producto).
- Clave primaria seleccionada: **id_detalle_compra** (existe constraint UNIQUE(id_compra, id_producto) para evitar duplicados de un mismo producto en una misma compra).

### Venta
- Llaves candidatas: id_venta, numero_factura.
- Clave primaria seleccionada: **id_venta**.

### DetalleVenta
- Llaves candidatas: id_detalle_venta, (id_venta, id_producto).
- Clave primaria seleccionada: **id_detalle_venta** (con UNIQUE(id_venta, id_producto)).

### MovimientoStock
- Llaves candidatas: id_movimiento.
- Clave primaria seleccionada: **id_movimiento**.

---

## Dependencias funcionales claramente definidas

### Catálogo

- id_categoria → nombre, descripción.
- id_marca → nombre, descripción.
- id_producto → sku, nombre, descripción, precio, stock, stock_minimo, activo, fecha_creacion, id_categoria, id_marca.
- sku → id_producto (sku es candidata, equivalente).

### Personas

- id_rol → nombre, descripción.
- id_empleado → nombres, apellidos, email, telefono, username, password_hash, activo, fecha_ingreso, id_rol, id_sucursal.
- email → id_empleado (única).
- username → id_empleado (única).
- id_proveedor → nombre, NIT, telefono, email, direccion, activo.
- NIT → id_proveedor (cuando NIT no es nulo).
- id_cliente → nombres, apellidos, NIT, telefono, email, direccion, fecha_registro, activo.

### Infraestructura

- id_sucursal → nombre, direccion, telefono, activa.
- id_metodo_pago → nombre, activo.

### Compras

- id_compra → fecha, numero_factura, subtotal, impuesto, total, estado, id_proveedor, id_empleado, id_sucursal.
- id_detalle_compra → cantidad, costo_unitario, subtotal, id_compra, id_producto.
- (id_compra, id_producto) → id_detalle_compra (UNIQUE).

### Ventas

- id_venta → fecha, numero_factura, subtotal, impuesto, total, estado, id_cliente, id_empleado, id_sucursal, id_metodo_pago.
- id_detalle_venta → cantidad, precio_unitario, subtotal, id_venta, id_producto.
- (id_venta, id_producto) → id_detalle_venta (UNIQUE).

### Trazabilidad

- id_movimiento → fecha, tipo, cantidad, stock_resultante, motivo, id_producto, id_empleado, id_sucursal, id_compra, id_venta.

---

## Normalización justificada hasta 3FN

### Punto de partida — diseño no normalizado

Si modeláramos toda la información del negocio en una sola tabla "operación", caeríamos en una estructura como la siguiente:

```
Operacion(numero_factura, fecha, tipo,
          producto_sku, producto_nombre, producto_categoria, producto_marca,
          cliente_nombre, cliente_nit,
          empleado_nombre, empleado_rol, empleado_sucursal,
          metodo_pago, cantidad, precio_unitario, subtotal, impuesto, total)
```

Este diseño presenta varios problemas que la normalización resuelve.

### Aplicación de 1FN (Primera Forma Normal)

**Regla:** todos los atributos deben ser atómicos (un valor por celda) y no deben existir grupos repetidos.

**Violación detectada en el diseño no normalizado:** una venta puede incluir varios productos. En el diseño plano esto obligaría a tener columnas como `producto1_sku, producto2_sku, producto3_sku, ...` o a guardar listas dentro de una celda (por ejemplo `"BRW-0001, BRW-0002"`). Ambos enfoques rompen 1FN.

**Solución aplicada:** se descompone la entidad "Operación" en una cabecera y un detalle:

- `Venta(id_venta, fecha, numero_factura, subtotal, impuesto, total, estado, ...)`
- `DetalleVenta(id_detalle_venta, id_venta, id_producto, cantidad, precio_unitario, subtotal)`

La misma técnica se aplica para las compras a proveedor:

- `CompraProveedor(id_compra, fecha, numero_factura, ...)`
- `DetalleCompra(id_detalle_compra, id_compra, id_producto, cantidad, costo_unitario, subtotal)`

Ahora, una venta con N productos genera 1 fila en `Venta` y N filas en `DetalleVenta`. Cada celda contiene un valor atómico.

### Aplicación de 2FN (Segunda Forma Normal)

**Regla:** estar en 1FN y, además, todo atributo no clave debe depender de la **clave primaria completa**, no solo de una parte de ella.

**Violación detectada (potencial):** si la PK de `DetalleVenta` fuera la combinación `(id_venta, id_producto)`, atributos como `precio_unitario` o `subtotal` dependen de la combinación completa, mientras que un atributo como `nombre_producto` (si lo hubiéramos guardado allí) dependería solo de `id_producto` — violando 2FN.

**Solución aplicada:**
- Se usa una clave primaria simple (`id_detalle_venta`) y se mantiene la combinación `(id_venta, id_producto)` como UNIQUE.
- No se duplican atributos del producto en el detalle: `nombre_producto` no existe en `DetalleVenta`, se obtiene siempre por JOIN a `Producto`.
- La única excepción es `precio_unitario`, que **sí se almacena** intencionalmente como snapshot. Esto se discute en la sección de denormalización justificada al final.

Como todas las claves primarias del proyecto son simples (todos los `id_*` son SERIAL, columnas únicas), 2FN se cumple de forma automática en todas las tablas.

### Aplicación de 3FN (Tercera Forma Normal)

**Regla:** estar en 2FN y, además, no debe existir ninguna dependencia transitiva — es decir, ningún atributo no clave debe depender de otro atributo no clave.

**Violaciones detectadas y solucionadas:**

#### a) Categoría y Marca como tablas separadas

En el diseño no normalizado, `Producto` tendría columnas como `categoria_nombre` y `marca_nombre` directamente. Esto introduce dos dependencias transitivas:

```
id_producto → categoria_nombre
id_producto → marca_nombre
```

Pero el `categoria_nombre` no depende realmente del producto: depende de qué categoría es. Si dos productos pertenecen a la categoría "Brownies Clásicos" y queremos renombrarla a "Brownies Tradicionales", tendríamos que actualizar todas las filas de `Producto` que usan esa categoría — anomalía de actualización clásica.

**Solución:** se extraen `Categoria` y `Marca` a tablas propias. `Producto` solo guarda `id_categoria` y `id_marca` como FKs. Renombrar una categoría es ahora un único `UPDATE Categoria SET nombre = … WHERE id_categoria = …`.

#### b) Rol como tabla separada

Originalmente, `Empleado` podría tener una columna `rol VARCHAR` con valores como `'Cajero'`, `'Pastelero Jefe'`, etc. Esto introduciría:

```
id_empleado → rol_nombre, rol_descripcion
```

Pero `rol_descripcion` depende de `rol_nombre`, no del empleado. Misma anomalía de actualización.

**Solución:** se extrae `Rol` a tabla propia. `Empleado` solo guarda `id_rol`.

#### c) Sucursal y MetodoPago como tablas separadas

El mismo razonamiento aplica para `Sucursal` (referenciada por Empleado, Venta, CompraProveedor, MovimientoStock) y para `MetodoPago` (referenciado por Venta). Si guardáramos `nombre_sucursal` o `nombre_metodo_pago` directamente en cada operación, el nombre de la sucursal dependería transitivamente de cuál sucursal es, no de cuál venta es.

**Solución:** se extraen ambas a tablas catálogo.

#### d) MovimientoStock con referencia polimórfica controlada

`MovimientoStock` registra entradas (por compra), salidas (por venta) y ajustes manuales. Una entrada exige saber la compra de origen; una salida exige saber la venta. Para no duplicar columnas como `tipo_origen, id_origen`, se modelan dos FKs nullable (`id_compra`, `id_venta`) más un constraint CHECK que garantiza la consistencia:

```sql
CHECK (
  (tipo = 'ENTRADA' AND id_compra IS NOT NULL AND id_venta IS NULL) OR
  (tipo = 'SALIDA'  AND id_venta  IS NOT NULL AND id_compra IS NULL) OR
  (tipo = 'AJUSTE'  AND id_compra IS NULL     AND id_venta  IS NULL)
)
```

Esto se conoce como **exclusive arc** y permite que la integridad de las referencias quede a nivel de la base, no de la aplicación. La tabla queda en 3FN porque cada atributo no-clave depende solo del `id_movimiento`.

### Denormalización justificada — snapshot del precio

`DetalleVenta.precio_unitario` aparenta romper 3FN: el precio del producto ya está en `Producto.precio`, así que `precio_unitario` parece depender transitivamente del producto.

**Sin embargo, no es una dependencia transitiva real:**
- `Producto.precio` es el precio **vigente** (puede cambiar).
- `DetalleVenta.precio_unitario` es el precio **al momento de la venta** (un snapshot inmutable).

Si el lunes vendo un brownie a Q30 y el martes subo el precio a Q35, la venta del lunes debe seguir reflejando Q30 en su factura. El snapshot rompe la dependencia funcional con `Producto.precio` *después de la venta*; los dos valores son independientes a partir de ese momento.

La misma justificación aplica para `DetalleCompra.costo_unitario` y para los campos `subtotal`, `impuesto`, `total` de las cabeceras de venta y compra: son valores históricos que no deben recalcularse a partir del estado actual.

### Resumen — todas las tablas en 3FN

| Tabla | 1FN | 2FN | 3FN |
|---|---|---|---|
| Categoria, Marca, Rol, Sucursal, MetodoPago | ✓ | ✓ (PK simple) | ✓ |
| Producto | ✓ | ✓ | ✓ (categoria y marca extraídas) |
| Empleado | ✓ | ✓ | ✓ (rol y sucursal extraídas) |
| Proveedor, Cliente | ✓ | ✓ | ✓ |
| CompraProveedor, Venta | ✓ | ✓ | ✓ (snapshots no son dependencias transitivas) |
| DetalleCompra, DetalleVenta | ✓ (descomposición de 1:N) | ✓ | ✓ |
| MovimientoStock | ✓ | ✓ | ✓ (exclusive arc en CHECK) |

---

## DER

El diagrama entidad-relación se encuentra en el archivo `Proyecto2Bases.drawio.png` del repositorio. Resume las 14 entidades y sus 1:N principales:

```
Categoria, Marca                          →  Producto
Rol, Sucursal                             →  Empleado
Proveedor, Empleado, Sucursal             →  CompraProveedor  →  DetalleCompra  ←  Producto
Cliente, Empleado, Sucursal, MetodoPago   →  Venta            →  DetalleVenta   ←  Producto
Producto, Empleado, Sucursal              →  MovimientoStock
CompraProveedor, Venta                    →  MovimientoStock (FK opcionales con exclusive arc)
```

Las relaciones N:M (Producto↔Compra y Producto↔Venta) están resueltas mediante las tablas de detalle. Todas las cardinalidades son 1:N de la tabla padre hacia la tabla hija.

---

## Modelo Relacional

Notación: cada esquema lista los atributos de la tabla. Las claves primarias se subrayan implícitamente al ser el primer atributo marcado como **PK**. Las claves foráneas se indican con `FK→Tabla(columna)`.

```
Categoria(id_categoria PK, nombre UNIQUE NOT NULL, descripcion)

Marca(id_marca PK, nombre UNIQUE NOT NULL, descripcion)

Producto(id_producto PK, sku UNIQUE NOT NULL, nombre NOT NULL, descripcion,
         precio NOT NULL CHECK(>=0), stock NOT NULL CHECK(>=0),
         stock_minimo NOT NULL CHECK(>=0), activo NOT NULL DEFAULT TRUE,
         fecha_creacion NOT NULL DEFAULT NOW(),
         id_categoria FK→Categoria(id_categoria) NOT NULL,
         id_marca     FK→Marca(id_marca)         NOT NULL)

Rol(id_rol PK, nombre UNIQUE NOT NULL, descripcion)

Sucursal(id_sucursal PK, nombre UNIQUE NOT NULL, direccion NOT NULL,
         telefono, activa NOT NULL DEFAULT TRUE)

Empleado(id_empleado PK, nombres NOT NULL, apellidos NOT NULL,
         email UNIQUE NOT NULL, telefono,
         username UNIQUE NOT NULL, password_hash NOT NULL,
         activo NOT NULL DEFAULT TRUE,
         fecha_ingreso NOT NULL DEFAULT CURRENT_DATE,
         id_rol      FK→Rol(id_rol)           NOT NULL,
         id_sucursal FK→Sucursal(id_sucursal) NOT NULL)

Proveedor(id_proveedor PK, nombre NOT NULL, nit UNIQUE,
          telefono, email, direccion,
          activo NOT NULL DEFAULT TRUE)

Cliente(id_cliente PK, nombres NOT NULL, apellidos NOT NULL,
        nit UNIQUE, telefono, email, direccion,
        fecha_registro NOT NULL DEFAULT NOW(),
        activo NOT NULL DEFAULT TRUE)

MetodoPago(id_metodo_pago PK, nombre UNIQUE NOT NULL,
           activo NOT NULL DEFAULT TRUE)

CompraProveedor(id_compra PK, fecha NOT NULL DEFAULT NOW(),
                numero_factura,
                subtotal NOT NULL CHECK(>=0),
                impuesto NOT NULL DEFAULT 0 CHECK(>=0),
                total    NOT NULL CHECK(>=0),
                estado   NOT NULL CHECK IN ('COMPLETADA','ANULADA'),
                id_proveedor FK→Proveedor(id_proveedor) NOT NULL,
                id_empleado  FK→Empleado(id_empleado)   NOT NULL,
                id_sucursal  FK→Sucursal(id_sucursal)   NOT NULL)

DetalleCompra(id_detalle_compra PK,
              id_compra   FK→CompraProveedor(id_compra) NOT NULL ON DELETE CASCADE,
              id_producto FK→Producto(id_producto)      NOT NULL,
              cantidad       NOT NULL CHECK(>0),
              costo_unitario NOT NULL CHECK(>=0),
              subtotal       NOT NULL CHECK(>=0),
              UNIQUE(id_compra, id_producto))

Venta(id_venta PK, fecha NOT NULL DEFAULT NOW(),
      numero_factura UNIQUE,
      subtotal NOT NULL CHECK(>=0),
      impuesto NOT NULL DEFAULT 0 CHECK(>=0),
      total    NOT NULL CHECK(>=0),
      estado   NOT NULL CHECK IN ('COMPLETADA','ANULADA'),
      id_cliente     FK→Cliente(id_cliente)        NULLABLE,
      id_empleado    FK→Empleado(id_empleado)      NOT NULL,
      id_sucursal    FK→Sucursal(id_sucursal)      NOT NULL,
      id_metodo_pago FK→MetodoPago(id_metodo_pago) NOT NULL)

DetalleVenta(id_detalle_venta PK,
             id_venta    FK→Venta(id_venta)        NOT NULL ON DELETE CASCADE,
             id_producto FK→Producto(id_producto)  NOT NULL,
             cantidad        NOT NULL CHECK(>0),
             precio_unitario NOT NULL CHECK(>=0),  -- snapshot al momento de venta
             subtotal        NOT NULL CHECK(>=0),
             UNIQUE(id_venta, id_producto))

MovimientoStock(id_movimiento PK,
                fecha NOT NULL DEFAULT NOW(),
                tipo  NOT NULL CHECK IN ('ENTRADA','SALIDA','AJUSTE'),
                cantidad         NOT NULL CHECK(<>0),
                stock_resultante NOT NULL CHECK(>=0),
                motivo,
                id_producto FK→Producto(id_producto)         NOT NULL,
                id_empleado FK→Empleado(id_empleado)         NOT NULL,
                id_sucursal FK→Sucursal(id_sucursal)         NOT NULL,
                id_compra   FK→CompraProveedor(id_compra)    NULLABLE,
                id_venta    FK→Venta(id_venta)               NULLABLE,
                CHECK exclusive arc:
                  (tipo='ENTRADA' AND id_compra NOT NULL AND id_venta NULL) OR
                  (tipo='SALIDA'  AND id_venta  NOT NULL AND id_compra NULL) OR
                  (tipo='AJUSTE'  AND id_compra NULL     AND id_venta NULL))
```

### Vista derivada utilizada por el backend

```
vw_producto_detalle =
  Producto ⨝ Categoria ⨝ Marca,
  con columna calculada stock_bajo := (stock <= stock_minimo)
```

Esta vista la consume el endpoint `GET /productos` del backend, evitando reescribir el JOIN cada vez.

---

## Script DDL

El DDL completo se encuentra en `db/init/01_schema.sql` del repositorio. Postgres lo carga automáticamente al primer arranque del contenedor de base de datos vía la convención `/docker-entrypoint-initdb.d/`.

A continuación se incluyen los fragmentos más representativos del schema. La versión completa son ~190 líneas e incluye todas las restricciones de PK, FK, NOT NULL, UNIQUE y CHECK.

```sql
-- Bloque catálogo
CREATE TABLE Categoria (
  id_categoria  SERIAL       PRIMARY KEY,
  nombre        VARCHAR(80)  NOT NULL UNIQUE,
  descripcion   TEXT
);

CREATE TABLE Marca (
  id_marca      SERIAL       PRIMARY KEY,
  nombre        VARCHAR(80)  NOT NULL UNIQUE,
  descripcion   TEXT
);

CREATE TABLE Producto (
  id_producto     SERIAL         PRIMARY KEY,
  sku             VARCHAR(40)    NOT NULL UNIQUE,
  nombre          VARCHAR(120)   NOT NULL,
  descripcion     TEXT,
  precio          NUMERIC(10,2)  NOT NULL CHECK (precio >= 0),
  stock           INT            NOT NULL DEFAULT 0 CHECK (stock >= 0),
  stock_minimo    INT            NOT NULL DEFAULT 0 CHECK (stock_minimo >= 0),
  activo          BOOLEAN        NOT NULL DEFAULT TRUE,
  fecha_creacion  TIMESTAMP      NOT NULL DEFAULT NOW(),
  id_categoria    INT            NOT NULL REFERENCES Categoria(id_categoria),
  id_marca        INT            NOT NULL REFERENCES Marca(id_marca)
);

-- Tabla con credenciales de login (sin tabla Usuario separada)
CREATE TABLE Empleado (
  id_empleado     SERIAL         PRIMARY KEY,
  nombres         VARCHAR(80)    NOT NULL,
  apellidos       VARCHAR(80)    NOT NULL,
  email           VARCHAR(120)   NOT NULL UNIQUE,
  telefono        VARCHAR(30),
  username        VARCHAR(40)    NOT NULL UNIQUE,
  password_hash   VARCHAR(200)   NOT NULL,
  activo          BOOLEAN        NOT NULL DEFAULT TRUE,
  fecha_ingreso   DATE           NOT NULL DEFAULT CURRENT_DATE,
  id_rol          INT            NOT NULL REFERENCES Rol(id_rol),
  id_sucursal     INT            NOT NULL REFERENCES Sucursal(id_sucursal)
);

-- Cabecera de venta
CREATE TABLE Venta (
  id_venta         SERIAL         PRIMARY KEY,
  fecha            TIMESTAMP      NOT NULL DEFAULT NOW(),
  numero_factura   VARCHAR(60)    UNIQUE,
  subtotal         NUMERIC(12,2)  NOT NULL CHECK (subtotal >= 0),
  impuesto         NUMERIC(12,2)  NOT NULL DEFAULT 0 CHECK (impuesto >= 0),
  total            NUMERIC(12,2)  NOT NULL CHECK (total >= 0),
  estado           VARCHAR(20)    NOT NULL DEFAULT 'COMPLETADA'
                     CHECK (estado IN ('COMPLETADA','ANULADA')),
  -- id_cliente NULLABLE: soporta venta de mostrador (Consumidor Final).
  id_cliente       INT            REFERENCES Cliente(id_cliente),
  id_empleado      INT            NOT NULL REFERENCES Empleado(id_empleado),
  id_sucursal      INT            NOT NULL REFERENCES Sucursal(id_sucursal),
  id_metodo_pago   INT            NOT NULL REFERENCES MetodoPago(id_metodo_pago)
);

CREATE TABLE DetalleVenta (
  id_detalle_venta  SERIAL         PRIMARY KEY,
  id_venta          INT            NOT NULL REFERENCES Venta(id_venta) ON DELETE CASCADE,
  id_producto       INT            NOT NULL REFERENCES Producto(id_producto),
  cantidad          INT            NOT NULL CHECK (cantidad > 0),
  precio_unitario   NUMERIC(10,2)  NOT NULL CHECK (precio_unitario >= 0),
  subtotal          NUMERIC(12,2)  NOT NULL CHECK (subtotal >= 0),
  UNIQUE (id_venta, id_producto)
);

-- Movimiento de stock con exclusive arc
CREATE TABLE MovimientoStock (
  id_movimiento     SERIAL       PRIMARY KEY,
  fecha             TIMESTAMP    NOT NULL DEFAULT NOW(),
  tipo              VARCHAR(10)  NOT NULL
                      CHECK (tipo IN ('ENTRADA','SALIDA','AJUSTE')),
  cantidad          INT          NOT NULL CHECK (cantidad <> 0),
  stock_resultante  INT          NOT NULL CHECK (stock_resultante >= 0),
  motivo            TEXT,
  id_producto       INT          NOT NULL REFERENCES Producto(id_producto),
  id_empleado       INT          NOT NULL REFERENCES Empleado(id_empleado),
  id_sucursal       INT          NOT NULL REFERENCES Sucursal(id_sucursal),
  id_compra         INT          REFERENCES CompraProveedor(id_compra),
  id_venta          INT          REFERENCES Venta(id_venta),
  CONSTRAINT chk_movimiento_arc CHECK (
    (tipo = 'ENTRADA' AND id_compra IS NOT NULL AND id_venta IS NULL  AND cantidad > 0) OR
    (tipo = 'SALIDA'  AND id_venta  IS NOT NULL AND id_compra IS NULL AND cantidad > 0) OR
    (tipo = 'AJUSTE'  AND id_compra IS NULL     AND id_venta  IS NULL)
  )
);
```

---

## Índices definidos

Los índices explícitos están en `db/init/03_indexes.sql`. Postgres ya genera índices automáticos para las restricciones `PRIMARY KEY` y `UNIQUE`, por lo que solo se crearon explícitamente los necesarios para acelerar consultas reales del sistema y que no son cubiertos por los automáticos.

```sql
-- (1) Reportes filtrados/agrupados por rango de fechas
CREATE INDEX idx_venta_fecha
  ON Venta (fecha);

-- (2) Reporte "top productos vendidos" (GROUP BY id_producto sobre DetalleVenta).
--     En Postgres las FKs no generan índice automático.
CREATE INDEX idx_detalle_venta_producto
  ON DetalleVenta (id_producto);

-- (3) Historial de stock por producto: "WHERE id_producto = X ORDER BY fecha DESC".
--     El compuesto (id_producto, fecha DESC) cubre filtro y orden en un solo
--     lookup, evitando un sort posterior.
CREATE INDEX idx_movimiento_producto_fecha
  ON MovimientoStock (id_producto, fecha DESC);

-- (4) Filtro UI por categoría y JOIN frecuente Producto→Categoria
CREATE INDEX idx_producto_categoria
  ON Producto (id_categoria);
```

### Justificación detallada por índice

| Índice | Consulta que acelera | Tipo |
|---|---|---|
| `idx_venta_fecha` | Reporte de ventas por rango (`WHERE fecha BETWEEN ...`), reportes diarios/mensuales | B-tree simple |
| `idx_detalle_venta_producto` | Reporte top productos (`GROUP BY id_producto, SUM(cantidad)`); también lookup "ventas que incluyeron producto X" | B-tree simple sobre FK |
| `idx_movimiento_producto_fecha` | Historial cronológico de stock por producto en pantalla de auditoría | B-tree compuesto con orden DESC en segunda columna |
| `idx_producto_categoria` | Filtro UI "ver solo brownies veganos", reporte de ventas agrupado por categoría | B-tree simple sobre FK |

El proyecto cumple ampliamente el requisito de "≥2 índices justificados" de la rúbrica con cuatro índices, todos sobre columnas que no son cubiertas por los índices automáticos generados por las restricciones UNIQUE/PRIMARY KEY de Postgres.

---

## Conclusiones

El diseño de la base de datos para Bubu's Bakery cumple con todas las restricciones de integridad relacional (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE, CHECK) y se encuentra normalizada hasta la tercera forma normal en sus 14 tablas. Las decisiones de denormalización (snapshot de precio, totales calculados en cabeceras) son intencionales y están justificadas por la necesidad de preservar la integridad histórica de las facturas.

El esquema es lo suficientemente expresivo para soportar las consultas analíticas del proyecto (CTEs, subqueries correlacionadas, agregaciones con `GROUP BY` y `HAVING`) y la operación transaccional crítica de venta (con `BEGIN`/`COMMIT`/`ROLLBACK` y `SELECT ... FOR UPDATE` para evitar condiciones de carrera). Los índices definidos cubren los patrones de acceso reales del sistema sin sobrecargar las operaciones de escritura.
