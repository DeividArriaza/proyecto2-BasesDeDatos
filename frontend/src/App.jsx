import { useEffect, useState } from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { api, palette } from './api.js';
import Login from './Login.jsx';
import Layout from './Layout.jsx';
import Catalog from './Catalog.jsx';
import ProductosAdmin from './ProductosAdmin.jsx';
import ClientesAdmin from './ClientesAdmin.jsx';
import Reportes from './Reportes.jsx';
import Ventas from './Ventas.jsx';

export default function App() {
  const [user, setUser] = useState(null);
  const [bootstrapped, setBootstrapped] = useState(false);

  useEffect(() => {
    api('/auth/me')
      .then((d) => setUser(d.user))
      .catch(() => setUser(null))
      .finally(() => setBootstrapped(true));
  }, []);

  if (!bootstrapped) {
    return (
      <div
        style={{
          minHeight: '100vh',
          display: 'grid',
          placeItems: 'center',
          background: palette.bg,
          color: palette.textSoft,
          fontFamily: '"Helvetica Neue", system-ui, sans-serif',
        }}
      >
        Cargando…
      </div>
    );
  }

  return (
    <BrowserRouter>
      <Routes>
        <Route
          path="/login"
          element={user ? <Navigate to="/" replace /> : <Login onLogin={setUser} />}
        />
        {user ? (
          <Route element={<Layout user={user} onLogout={() => setUser(null)} />}>
            <Route path="/" element={<Catalog />} />
            <Route path="/productos" element={<ProductosAdmin />} />
            <Route path="/clientes" element={<ClientesAdmin />} />
            <Route path="/ventas" element={<Ventas />} />
            <Route path="/reportes" element={<Reportes />} />
            <Route path="*" element={<Navigate to="/" replace />} />
          </Route>
        ) : (
          <Route path="*" element={<Navigate to="/login" replace />} />
        )}
      </Routes>
    </BrowserRouter>
  );
}
