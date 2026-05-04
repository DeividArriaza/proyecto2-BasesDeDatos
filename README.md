# Bubu's Bakery

Aplicación web para administrar el inventario y las ventas de **Bubu's Bakery**, una repostería boutique guatemalteca especializada en brownies artesanales. Proyecto 2 del curso **cc3088 — Bases de Datos 1** (UVG, Ciclo 1 — 2026).

Levanta tres contenedores (PostgreSQL, backend Node/Express, frontend React/Vite) con un solo comando: `docker compose up`.

---

## Stack

| Capa     | Tecnología                                |
| -------- | ----------------------------------------- |
| DB       | PostgreSQL 16 (alpine)                    |
| Backend  | Node 20 + Express 4 + driver `pg` (sin ORM, SQL crudo) |
| Frontend | React 18 + Vite 5 + react-router-dom 6    |
| Auth     | `express-session` + `bcrypt`              |
| Infra    | Docker Compose                            |

Todas las consultas son **SQL explícito**, sin ORMs que oculten el SQL.

---

## Requisitos previos

- Docker y Docker Compose instalados.
- Puertos `55432`, `58080` y `58081` libres en el host.

---

## Levantar el proyecto

```bash
git clone <url-del-repo>
cd proyecto2-BasesDeDatos
cp .env.example .env
docker compose up --build
```

Cuando los tres servicios estén `healthy/up` (≈ 30 segundos):

| Servicio | URL                                  |
| -------- | ------------------------------------ |
| Frontend | <http://localhost:58081>             |
| Backend  | <http://localhost:58080> (`/health`) |
| DB       | `localhost:55432` (Postgres)         |

Abrí el frontend, va a redirigir automáticamente a `/login`. Las credenciales para entrar son:

```
usuario:    ericka
contraseña: demo123
```

Detener: `docker compose down` (preserva datos) o `docker compose down -v` (borra el volumen y vuelve a sembrar).

---

## Credenciales

### Base de datos (fijas, exigidas por la rúbrica)

```
usuario:    proy2
contraseña: secret
db:         tienda
```

### Login en la aplicación

```
usuario:    ericka
contraseña: demo123
```

Ericka Sandoval es la administradora (rol `Administrador`, sucursal `Bubu's Bakery`). Los otros 24 empleados también pueden iniciar sesión con `demo123`, pero solo Ericka tiene rol de admin.

---

## Estructura del proyecto

```
.
├── docker-compose.yml         # 3 servicios + red interna + volumen pgdata
├── .env / .env.example         # credenciales y puertos
├── db/
│   ├── Dockerfile              # extiende postgres:16-alpine
│   └── init/                   # cargados en orden alfabético al primer boot
│       ├── 01_schema.sql       # 14 tablas con PK/FK/NOT NULL/CHECK
│       ├── 02_seed.sql         # ≥25 registros por tabla, en transacción
│       ├── 03_indexes.sql      # 4 índices justificados
│       └── 04_views.sql        # vw_producto_detalle (consumida por backend)
├── backend/
│   ├── Dockerfile
│   └── src/
│       ├── index.js            # bootstrap Express + sesión + CORS
│       ├── db.js               # pool de Postgres
│       ├── middleware.js       # cors manual + requireAuth
│       └── routes/
│           ├── auth.js         # login / logout / me (bcrypt + sesión)
│           ├── productos.js    # CRUD + bajo-stock (lee de la VIEW)
│           ├── clientes.js     # CRUD con soft delete
│           ├── ventas.js       # POST con BEGIN/COMMIT/ROLLBACK + GET
│           ├── reportes.js     # 4 reportes (CTE, GROUP BY/HAVING, subqueries)
│           └── catalogos.js    # /categorias, /marcas, /metodos-pago
└── frontend/
    ├── Dockerfile
    └── src/
        ├── App.jsx             # rutas protegidas
        ├── api.js              # fetch con credentials + paleta
        ├── Login.jsx           # página de inicio de sesión
        ├── Layout.jsx          # header + nav + Modal/banners reutilizables
        ├── Catalog.jsx         # listado público de productos
        ├── ProductosAdmin.jsx  # CRUD producto (modal + tabla)
        ├── ClientesAdmin.jsx   # CRUD cliente (modal + tabla)
        ├── Ventas.jsx          # form de venta (transacción) + listado
        └── Reportes.jsx        # 4 reportes con tabs + export CSV
```

---

## Funcionalidades

### Autenticación
- Login y logout con `express-session` (cookie HTTP-only, sameSite lax).
- Las contraseñas en la base están guardadas como hash bcrypt.
- Páginas protegidas redirigen a `/login` si no hay sesión.

### CRUD
- **Productos**: alta, edición, listado y borrado lógico (`activo=FALSE`). Los formularios incluyen dropdowns alimentados por `Categoría` y `Marca`.
- **Clientes**: mismo patrón. Soft delete preserva las FKs históricas en `Venta`.

### Ventas
- Página `/ventas` con formulario para registrar una venta. El backend ejecuta una **transacción explícita**: inserta la venta, los detalles, actualiza el stock y registra los movimientos. Si en cualquier punto falla (stock insuficiente, FK inválido, etc.) se hace `ROLLBACK` y se reporta el error en la UI.

### Reportes (`/reportes`)
1. **Top productos más vendidos** — usa CTE `WITH ranking AS (...)`.
2. **Ventas por sucursal** — `GROUP BY` + `HAVING SUM(total) > 1000` + agregados.
3. **Productos críticos** — subquery escalar (promedio de stock) + subquery con `IN`.
4. **Clientes frecuentes** — subquery correlacionada `EXISTS` (clientes que compraron brownies).

Cada reporte tiene un botón **Exportar CSV** que genera el archivo del lado del cliente.

### Manejo de errores en UI
Banners reutilizables (`ErrorBanner` / `SuccessBanner`) en cada página. Los errores del backend (por ejemplo, el `ROLLBACK` de la transacción) se muestran al usuario.

---

## Mapeo a la rúbrica

| Sección                                    | Pts | Ubicación                                                                 |
| ------------------------------------------ | --- | ------------------------------------------------------------------------- |
| **I. Diseño DB**                           |     |                                                                           |
| Diagrama ER                                | 8   | `Proyecto2Bases.drawio.png`                                               |
| Modelo relacional                          | 7   | `docs/modelo_relacional.md` (entrega aparte)                              |
| Normalización 3FN                          | 10  | `docs/normalizacion_3fn.md` (entrega aparte)                              |
| DDL completo                               | 5   | `db/init/01_schema.sql`                                                   |
| Seed ≥25 registros/tabla                   | 5   | `db/init/02_seed.sql`                                                     |
| ≥2 índices con justificación               | 5   | `db/init/03_indexes.sql` (4 índices)                                      |
| **II. SQL**                                |     |                                                                           |
| 3 JOINs visibles en UI                     | 10  | `/productos`, `/ventas`, reportes                                         |
| 2 subqueries visibles en UI                | 10  | Reporte "Productos críticos" + "Clientes frecuentes"                       |
| GROUP BY + HAVING + agregados              | 8   | Reporte "Ventas por sucursal"                                             |
| ≥1 CTE                                     | 5   | Reporte "Top productos más vendidos"                                      |
| ≥1 VIEW usado por backend                  | 5   | `vw_producto_detalle` consumida por `GET /productos`                      |
| Transacción con ROLLBACK                   | 12  | `POST /ventas` en `backend/src/routes/ventas.js`                          |
| **III. App web**                           |     |                                                                           |
| CRUD ≥2 entidades                          | 15  | Productos + Clientes                                                      |
| ≥1 reporte con datos reales                | 10  | `/reportes` (4 reportes)                                                  |
| Manejo de errores en UI                    | 5   | `ErrorBanner`/`SuccessBanner` en todas las páginas                         |
| README                                     | 5   | Este archivo                                                              |
| **IV. Avanzado**                           |     |                                                                           |
| Auth login/logout con sesión               | 10  | `/auth/login`, `/auth/logout`, `/auth/me`                                 |
| Exportar reporte a CSV                     | 5   | Botón "↓ Exportar CSV" en cada reporte                                    |

---

## Endpoints principales

| Método | Ruta                                | Descripción                              | Auth |
| ------ | ----------------------------------- | ---------------------------------------- | ---- |
| GET    | `/health`                           | Status del backend + ping a DB           | no   |
| POST   | `/auth/login`                       | Inicia sesión                            | no   |
| POST   | `/auth/logout`                      | Cierra sesión                            | no   |
| GET    | `/auth/me`                          | Usuario actual                           | no   |
| GET    | `/productos`                        | Listado (lee de la VIEW)                 | no   |
| GET    | `/productos/bajo-stock`             | Productos con stock ≤ stock_minimo       | no   |
| POST/PUT/DELETE | `/productos[/:id]`         | CRUD                                     | sí   |
| GET    | `/clientes`                         | Listado                                  | sí   |
| POST/PUT/DELETE | `/clientes[/:id]`          | CRUD                                     | sí   |
| GET    | `/ventas`                           | Listado con JOIN a Cliente/Sucursal/...  | sí   |
| POST   | `/ventas`                           | Registra venta (transacción ROLLBACK)    | sí   |
| GET    | `/reportes/top-productos`           | CTE                                      | sí   |
| GET    | `/reportes/ventas-por-sucursal`     | GROUP BY + HAVING                        | sí   |
| GET    | `/reportes/productos-criticos`      | 2 subqueries                             | sí   |
| GET    | `/reportes/clientes-frecuentes`     | EXISTS correlacionada                    | sí   |
| GET    | `/categorias`, `/marcas`, `/metodos-pago` | Catálogos para dropdowns           | no   |

---

## Notas operativas

- Los puertos están elegidos en rango `5xxxx` para evitar conflictos con servicios comunes (Postgres `5432`, Vite `5173`, etc.). El `.env` controla los tres puertos del proyecto.
- Cuando se agregan dependencias nuevas al backend o frontend hay que reconstruir limpio: `docker compose down -v && docker compose up --build`. El `-v` borra el volumen anónimo de `node_modules`.
- El seed se ejecuta solo en el primer boot (cuando el volumen `pgdata` está vacío). Para re-sembrar, hacer `docker compose down -v` antes de levantar.
