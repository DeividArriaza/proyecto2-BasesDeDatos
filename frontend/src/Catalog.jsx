import { useEffect, useState } from 'react';
import { api, palette } from './api.js';
import { ErrorBanner } from './Layout.jsx';
import { PageHeader } from './ProductosAdmin.jsx';

export default function Catalog() {
  const [productos, setProductos] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    api('/productos')
      .then(setProductos)
      .catch((e) => setError(e.message))
      .finally(() => setLoading(false));
  }, []);

  return (
    <div>
      <PageHeader
        title="Catálogo de productos"
        subtitle={loading ? 'Cargando…' : `${productos.length} productos disponibles`}
      />

      <ErrorBanner error={error} onClose={() => setError(null)} />

      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fill, minmax(260px, 1fr))',
          gap: 18,
        }}
      >
        {productos.map((p) => (
          <article
            key={p.id_producto}
            style={{
              background: palette.surface,
              borderRadius: 18,
              padding: 18,
              border: `1px solid ${palette.border}`,
              boxShadow: '0 4px 18px rgba(199, 21, 133, 0.08)',
              display: 'flex',
              flexDirection: 'column',
              gap: 8,
              position: 'relative',
            }}
          >
            {p.stock_bajo && (
              <span
                style={{
                  position: 'absolute',
                  top: 12,
                  right: 12,
                  background: palette.accent,
                  color: 'white',
                  fontSize: '0.65rem',
                  padding: '2px 8px',
                  borderRadius: 999,
                  textTransform: 'uppercase',
                  letterSpacing: 1,
                  fontWeight: 700,
                }}
              >
                Bajo stock
              </span>
            )}
            <div
              style={{
                fontSize: '0.7rem',
                color: palette.accent,
                textTransform: 'uppercase',
                letterSpacing: 1.2,
                fontWeight: 600,
              }}
            >
              {p.categoria} · {p.marca}
            </div>
            <h3 style={{ margin: 0, color: palette.text, fontSize: '1.1rem' }}>{p.nombre}</h3>
            <p
              style={{
                margin: 0,
                color: palette.textSoft,
                fontSize: '0.85rem',
                flex: 1,
                minHeight: 38,
              }}
            >
              {p.descripcion}
            </p>
            <div
              style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'baseline',
                marginTop: 6,
              }}
            >
              <span style={{ fontSize: '1.5rem', fontWeight: 800, color: palette.primary }}>
                Q{Number(p.precio).toFixed(2)}
              </span>
              <span style={{ fontSize: '0.8rem', color: palette.textSoft }}>
                Stock: {p.stock}
              </span>
            </div>
            <div style={{ fontSize: '0.7rem', color: '#B89DAB', marginTop: 4 }}>{p.sku}</div>
          </article>
        ))}
      </div>
    </div>
  );
}
