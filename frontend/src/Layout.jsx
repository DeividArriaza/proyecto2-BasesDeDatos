import { useState } from 'react';
import { NavLink, Outlet, useNavigate } from 'react-router-dom';
import { api, palette } from './api.js';

export default function Layout({ user, onLogout }) {
  const navigate = useNavigate();
  const [busy, setBusy] = useState(false);

  async function handleLogout() {
    setBusy(true);
    try {
      await api('/auth/logout', { method: 'POST' });
      onLogout();
      navigate('/login', { replace: true });
    } catch {
      setBusy(false);
    }
  }

  return (
    <div
      style={{
        minHeight: '100vh',
        background: `linear-gradient(180deg, ${palette.bg} 0%, #FFE4EE 100%)`,
        fontFamily: '"Helvetica Neue", system-ui, sans-serif',
        color: palette.text,
      }}
    >
      <header
        style={{
          background: palette.surface,
          borderBottom: `1px solid ${palette.border}`,
          padding: '14px 28px',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          gap: 24,
          flexWrap: 'wrap',
          boxShadow: '0 2px 12px rgba(199, 21, 133, 0.06)',
        }}
      >
        <div style={{ display: 'flex', alignItems: 'baseline', gap: 18 }}>
          <h1
            style={{
              color: palette.primary,
              fontSize: '1.6rem',
              margin: 0,
              fontWeight: 800,
              letterSpacing: '-0.5px',
            }}
          >
            Bubu's Bakery
          </h1>
          <nav style={{ display: 'flex', gap: 6 }}>
            <NavItem to="/" label="Catálogo" />
            <NavItem to="/productos" label="Productos" />
            <NavItem to="/clientes" label="Clientes" />
            <NavItem to="/ventas" label="Ventas" />
            <NavItem to="/reportes" label="Reportes" />
          </nav>
        </div>

        <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
          <div style={{ textAlign: 'right' }}>
            <div style={{ fontSize: '0.75rem', color: palette.textSoft }}>
              {user.rol} · {user.sucursal}
            </div>
            <div style={{ fontWeight: 700, color: palette.text, fontSize: '0.95rem' }}>
              {user.nombres} {user.apellidos}
            </div>
          </div>
          <button
            onClick={handleLogout}
            disabled={busy}
            style={{
              background: 'transparent',
              border: `1px solid ${palette.primary}`,
              color: palette.primary,
              padding: '6px 14px',
              borderRadius: 999,
              cursor: busy ? 'wait' : 'pointer',
              fontWeight: 600,
              fontSize: '0.85rem',
            }}
          >
            {busy ? 'Cerrando…' : 'Cerrar sesión'}
          </button>
        </div>
      </header>

      <main style={{ maxWidth: 1200, margin: '0 auto', padding: '32px 28px 80px' }}>
        <Outlet />
      </main>
    </div>
  );
}

function NavItem({ to, label }) {
  return (
    <NavLink
      to={to}
      end={to === '/'}
      style={({ isActive }) => ({
        textDecoration: 'none',
        padding: '6px 14px',
        borderRadius: 999,
        fontWeight: 600,
        fontSize: '0.9rem',
        color: isActive ? 'white' : palette.textSoft,
        background: isActive ? palette.primary : 'transparent',
      })}
    >
      {label}
    </NavLink>
  );
}

// Banner de error reutilizable. Aceptamos string u objeto Error.
export function ErrorBanner({ error, onClose }) {
  if (!error) return null;
  const message = typeof error === 'string' ? error : error.message || 'Error desconocido';
  return (
    <div
      role="alert"
      style={{
        background: palette.errorBg,
        border: `1px solid ${palette.errorBd}`,
        color: palette.textSoft,
        padding: '12px 16px',
        borderRadius: 12,
        marginBottom: 18,
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        gap: 12,
      }}
    >
      <span>
        <strong style={{ color: palette.primary }}>Error: </strong>
        {message}
      </span>
      {onClose && (
        <button
          onClick={onClose}
          style={{
            border: 'none',
            background: 'transparent',
            color: palette.primary,
            cursor: 'pointer',
            fontWeight: 700,
            fontSize: '1.1rem',
            padding: '0 4px',
          }}
        >
          ×
        </button>
      )}
    </div>
  );
}

// Modal/diálogo reutilizable para los formularios CRUD.
export function Modal({ open, title, onClose, children }) {
  if (!open) return null;
  return (
    <div
      onClick={onClose}
      style={{
        position: 'fixed',
        inset: 0,
        background: 'rgba(74, 16, 49, 0.45)',
        display: 'grid',
        placeItems: 'center',
        zIndex: 50,
        padding: 16,
      }}
    >
      <div
        onClick={(e) => e.stopPropagation()}
        style={{
          background: palette.surface,
          borderRadius: 18,
          padding: 24,
          width: '100%',
          maxWidth: 520,
          maxHeight: '90vh',
          overflowY: 'auto',
          boxShadow: '0 12px 40px rgba(199, 21, 133, 0.2)',
        }}
      >
        <div
          style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            marginBottom: 16,
          }}
        >
          <h3 style={{ margin: 0, color: palette.primary }}>{title}</h3>
          <button
            onClick={onClose}
            style={{
              border: 'none',
              background: 'transparent',
              color: palette.textSoft,
              cursor: 'pointer',
              fontSize: '1.4rem',
              padding: 4,
              lineHeight: 1,
            }}
          >
            ×
          </button>
        </div>
        {children}
      </div>
    </div>
  );
}

// Estilos de input/label compartidos por los formularios CRUD.
export const formStyles = {
  label: {
    display: 'block',
    fontSize: '0.7rem',
    color: palette.textSoft,
    textTransform: 'uppercase',
    letterSpacing: 1,
    fontWeight: 600,
    marginTop: 12,
    marginBottom: 4,
  },
  input: {
    display: 'block',
    width: '100%',
    boxSizing: 'border-box',
    padding: '9px 12px',
    border: `1px solid ${palette.border}`,
    borderRadius: 10,
    fontSize: '0.9rem',
    outline: 'none',
    background: palette.bg,
    color: palette.text,
    fontFamily: 'inherit',
  },
  primaryBtn: {
    background: palette.primary,
    border: 'none',
    color: 'white',
    padding: '9px 18px',
    borderRadius: 999,
    cursor: 'pointer',
    fontWeight: 700,
    fontSize: '0.9rem',
  },
  ghostBtn: {
    background: 'transparent',
    border: `1px solid ${palette.border}`,
    color: palette.textSoft,
    padding: '9px 18px',
    borderRadius: 999,
    cursor: 'pointer',
    fontWeight: 600,
    fontSize: '0.9rem',
  },
};

// Banner de éxito (para confirmaciones de acciones CRUD).
export function SuccessBanner({ message, onClose }) {
  if (!message) return null;
  return (
    <div
      role="status"
      style={{
        background: '#E8F8EE',
        border: '1px solid #BAE6CB',
        color: '#1F6B3D',
        padding: '12px 16px',
        borderRadius: 12,
        marginBottom: 18,
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        gap: 12,
      }}
    >
      <span>
        <strong>OK: </strong>
        {message}
      </span>
      {onClose && (
        <button
          onClick={onClose}
          style={{
            border: 'none',
            background: 'transparent',
            color: '#1F6B3D',
            cursor: 'pointer',
            fontWeight: 700,
            fontSize: '1.1rem',
            padding: '0 4px',
          }}
        >
          ×
        </button>
      )}
    </div>
  );
}
