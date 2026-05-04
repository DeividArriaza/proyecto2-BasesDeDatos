import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { api, palette } from './api.js';

export default function Catalog({ user, onLogout }) {
  const navigate = useNavigate();
  const [productos, setProductos] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [busyLogout, setBusyLogout] = useState(false);

  useEffect(() => {
    api('/productos')
      .then(setProductos)
      .catch((e) => setError(e.message))
      .finally(() => setLoading(false));
  }, []);

  async function handleLogout() {
    setBusyLogout(true);
    try {
      await api('/auth/logout', { method: 'POST' });
      onLogout();
      navigate('/login', { replace: true });
    } catch (err) {
      setError(err.message);
      setBusyLogout(false);
    }
  }

  return (
    <div
      style={{
        minHeight: '100vh',
        background: `linear-gradient(180deg, ${palette.bg} 0%, #FFE4EE 100%)`,
        fontFamily: '"Helvetica Neue", system-ui, sans-serif',
        padding: '40px 24px 80px',
        color: palette.text,
      }}
    >
      <header
        style={{
          maxWidth: 1100,
          margin: '0 auto 32px',
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'flex-start',
          gap: 24,
          flexWrap: 'wrap',
        }}
      >
        <div>
          <div
            style={{
              display: 'inline-block',
              background: palette.primary,
              color: 'white',
              padding: '4px 14px',
              borderRadius: 999,
              fontSize: '0.7rem',
              letterSpacing: 2,
              textTransform: 'uppercase',
              fontWeight: 600,
            }}
          >
            Repostería boutique
          </div>
          <h1
            style={{
              color: palette.primary,
              fontSize: '3rem',
              margin: '12px 0 4px',
              fontWeight: 800,
              letterSpacing: '-1px',
            }}
          >
            Bubu's Bakery
          </h1>
          <p style={{ color: palette.textSoft, margin: 0, fontSize: '1.05rem' }}>
            Especialistas en brownies artesanales · Guatemala
          </p>
        </div>
        <div
          style={{
            background: palette.surface,
            border: `1px solid ${palette.border}`,
            borderRadius: 14,
            padding: 14,
            minWidth: 260,
            boxShadow: '0 4px 18px rgba(199, 21, 133, 0.08)',
          }}
        >
          <div
            style={{
              fontSize: '0.7rem',
              color: palette.accent,
              textTransform: 'uppercase',
              letterSpacing: 1.2,
              fontWeight: 600,
            }}
          >
            Sesión activa
          </div>
          <div style={{ fontWeight: 700, margin: '4px 0', color: palette.text }}>
            {user.nombres} {user.apellidos}
          </div>
          <div style={{ fontSize: '0.85rem', color: palette.textSoft }}>
            {user.rol} · {user.sucursal}
          </div>
          <button
            onClick={handleLogout}
            disabled={busyLogout}
            style={{
              marginTop: 10,
              background: 'transparent',
              border: `1px solid ${palette.primary}`,
              color: palette.primary,
              padding: '6px 14px',
              borderRadius: 999,
              cursor: busyLogout ? 'wait' : 'pointer',
              fontWeight: 600,
              fontSize: '0.85rem',
            }}
          >
            {busyLogout ? 'Cerrando…' : 'Cerrar sesión'}
          </button>
        </div>
      </header>

      <main style={{ maxWidth: 1100, margin: '0 auto' }}>
        <div
          style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'baseline',
            marginBottom: 16,
          }}
        >
          <h2 style={{ color: palette.primary, margin: 0 }}>Catálogo de productos</h2>
          <span style={{ color: palette.textSoft, fontSize: '0.9rem' }}>
            {loading ? 'Cargando…' : `${productos.length} productos`}
          </span>
        </div>

        {error && (
          <div
            style={{
              background: palette.errorBg,
              border: `1px solid ${palette.errorBd}`,
              color: palette.textSoft,
              padding: 14,
              borderRadius: 12,
              marginBottom: 24,
            }}
          >
            <strong>Error:</strong> {error}
          </div>
        )}

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
      </main>
    </div>
  );
}
