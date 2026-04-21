import { useEffect, useState } from 'react';

export default function App() {
  const [status, setStatus] = useState('cargando...');

  useEffect(() => {
    fetch(`${import.meta.env.VITE_API_URL}/health`)
      .then((r) => r.json())
      .then((d) => setStatus(JSON.stringify(d)))
      .catch((e) => setStatus(`error: ${e.message}`));
  }, []);

  return (
    <div style={{ fontFamily: 'system-ui, sans-serif', padding: 24 }}>
      <h1>Proyecto 2 — Tienda</h1>
      <p><strong>Backend /health:</strong> {status}</p>
    </div>
  );
}
