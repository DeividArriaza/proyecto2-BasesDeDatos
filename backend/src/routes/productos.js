import { Router } from 'express';
import { pool } from '../db.js';

export const productosRouter = Router();

// Lee de vw_producto_detalle (CREATE VIEW en db/init/04_views.sql).
// La vista encapsula JOIN Producto + Categoria + Marca + flag stock_bajo.
productosRouter.get('/', async (_req, res) => {
  try {
    const { rows } = await pool.query(`
      SELECT *
      FROM vw_producto_detalle
      WHERE activo = TRUE
      ORDER BY id_producto
    `);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

productosRouter.get('/bajo-stock', async (_req, res) => {
  try {
    const { rows } = await pool.query(`
      SELECT *
      FROM vw_producto_detalle
      WHERE activo = TRUE AND stock_bajo = TRUE
      ORDER BY (stock - stock_minimo) ASC
    `);
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
