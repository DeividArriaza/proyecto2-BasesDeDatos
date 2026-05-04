import { useEffect, useMemo, useState } from 'react';
import { api, palette } from './api.js';
import { ErrorBanner, SuccessBanner, formStyles } from './Layout.jsx';
import { PageHeader } from './ProductosAdmin.jsx';

const IVA = 0.12;
const lineaVacia = () => ({ id_producto: '', cantidad: 1 });

export default function Ventas() {
  const [ventas, setVentas] = useState([]);
  const [productos, setProductos] = useState([]);
  const [clientes, setClientes] = useState([]);
  const [metodos, setMetodos] = useState([]);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);
  const [submitting, setSubmitting] = useState(false);

  const [form, setForm] = useState({
    id_cliente: '',
    id_metodo_pago: '',
    items: [lineaVacia()],
  });

  async function load() {
    try {
      const [vs, ps, cs, ms] = await Promise.all([
        api('/ventas'),
        api('/productos'),
        api('/clientes'),
        api('/metodos-pago'),
      ]);
      setVentas(vs);
      setProductos(ps);
      setClientes(cs);
      setMetodos(ms);
    } catch (err) {
      setError(err.message);
    }
  }

  useEffect(() => { load(); }, []);

  const productoMap = useMemo(
    () => Object.fromEntries(productos.map((p) => [String(p.id_producto), p])),
    [productos]
  );

  const totales = useMemo(() => {
    let subtotal = 0;
    for (const it of form.items) {
      const p = productoMap[String(it.id_producto)];
      if (!p) continue;
      subtotal += Number(p.precio) * Number(it.cantidad || 0);
    }
    const impuesto = +(subtotal * IVA).toFixed(2);
    return { subtotal: +subtotal.toFixed(2), impuesto, total: +(subtotal + impuesto).toFixed(2) };
  }, [form.items, productoMap]);

  function setField(name, value) {
    setForm((f) => ({ ...f, [name]: value }));
  }

  function setLinea(idx, field, value) {
    setForm((f) => {
      const items = [...f.items];
      items[idx] = { ...items[idx], [field]: value };
      return { ...f, items };
    });
  }

  function addLinea() {
    setForm((f) => ({ ...f, items: [...f.items, lineaVacia()] }));
  }

  function removeLinea(idx) {
    setForm((f) => ({ ...f, items: f.items.filter((_, i) => i !== idx) }));
  }

  function resetForm() {
    setForm({ id_cliente: '', id_metodo_pago: '', items: [lineaVacia()] });
  }

  async function handleSubmit(e) {
    e.preventDefault();
    setError(null);
    setSuccess(null);

    const items = form.items
      .filter((it) => it.id_producto && Number(it.cantidad) > 0)
      .map((it) => ({ id_producto: Number(it.id_producto), cantidad: Number(it.cantidad) }));

    if (items.length === 0) {
      setError('Agregá al menos un producto con cantidad mayor a 0');
      return;
    }
    if (!form.id_metodo_pago) {
      setError('Seleccioná un método de pago');
      return;
    }

    setSubmitting(true);
    try {
      const result = await api('/ventas', {
        method: 'POST',
        body: JSON.stringify({
          id_cliente: form.id_cliente ? Number(form.id_cliente) : null,
          id_metodo_pago: Number(form.id_metodo_pago),
          items,
        }),
      });
      setSuccess(`Venta ${result.numero_factura} registrada — total Q${Number(result.total).toFixed(2)}`);
      resetForm();
      await load();
    } catch (err) {
      // El backend hace ROLLBACK y devuelve el mensaje (ej. stock insuficiente).
      setError(err.message);
    } finally {
      setSubmitting(false);
    }
  }

  return (
    <div>
      <PageHeader
        title="Ventas"
        subtitle="Registrar nueva venta y consultar historial reciente"
      />

      <ErrorBanner error={error} onClose={() => setError(null)} />
      <SuccessBanner message={success} onClose={() => setSuccess(null)} />

      <div
        style={{
          background: palette.surface,
          border: `1px solid ${palette.border}`,
          borderRadius: 16,
          padding: 22,
          marginBottom: 28,
          boxShadow: '0 4px 18px rgba(199, 21, 133, 0.06)',
        }}
      >
        <h3 style={{ margin: '0 0 4px', color: palette.primary }}>Nueva venta</h3>
        <p style={{ margin: '0 0 18px', color: palette.textSoft, fontSize: '0.9rem' }}>
          Esta operación corre dentro de una transacción explícita
          (BEGIN/COMMIT/ROLLBACK). Si el stock es insuficiente o falla cualquier
          paso, no se persiste nada.
        </p>

        <form onSubmit={handleSubmit}>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 14 }}>
            <Field label="Cliente">
              <select
                value={form.id_cliente}
                onChange={(e) => setField('id_cliente', e.target.value)}
                style={formStyles.input}
              >
                <option value="">Consumidor Final</option>
                {clientes.map((c) => (
                  <option key={c.id_cliente} value={c.id_cliente}>
                    {c.nombres} {c.apellidos} {c.nit ? `· ${c.nit}` : ''}
                  </option>
                ))}
              </select>
            </Field>
            <Field label="Método de pago" required>
              <select
                required
                value={form.id_metodo_pago}
                onChange={(e) => setField('id_metodo_pago', e.target.value)}
                style={formStyles.input}
              >
                <option value="">— elegir —</option>
                {metodos.map((m) => (
                  <option key={m.id_metodo_pago} value={m.id_metodo_pago}>{m.nombre}</option>
                ))}
              </select>
            </Field>
          </div>

          <div style={{ marginTop: 18 }}>
            <label style={formStyles.label}>Productos</label>
            <div
              style={{
                background: palette.bg,
                borderRadius: 12,
                border: `1px solid ${palette.border}`,
                overflow: 'hidden',
              }}
            >
              <div
                style={{
                  display: 'grid',
                  gridTemplateColumns: '1fr 110px 110px 110px 36px',
                  background: '#FFE0EC',
                  padding: '8px 12px',
                  fontSize: '0.7rem',
                  textTransform: 'uppercase',
                  color: palette.textSoft,
                  fontWeight: 600,
                  letterSpacing: 0.5,
                }}
              >
                <div>Producto</div>
                <div style={{ textAlign: 'right' }}>Cantidad</div>
                <div style={{ textAlign: 'right' }}>Precio</div>
                <div style={{ textAlign: 'right' }}>Subtotal</div>
                <div></div>
              </div>
              {form.items.map((linea, idx) => {
                const p = productoMap[String(linea.id_producto)];
                const subtotalLinea = p ? Number(p.precio) * Number(linea.cantidad || 0) : 0;
                return (
                  <div
                    key={idx}
                    style={{
                      display: 'grid',
                      gridTemplateColumns: '1fr 110px 110px 110px 36px',
                      padding: '8px 12px',
                      gap: 8,
                      alignItems: 'center',
                      borderTop: idx === 0 ? 'none' : `1px solid ${palette.border}`,
                    }}
                  >
                    <select
                      value={linea.id_producto}
                      onChange={(e) => setLinea(idx, 'id_producto', e.target.value)}
                      style={{ ...formStyles.input, padding: '6px 10px', fontSize: '0.85rem' }}
                    >
                      <option value="">— elegir producto —</option>
                      {productos.map((pr) => (
                        <option key={pr.id_producto} value={pr.id_producto}>
                          {pr.sku} · {pr.nombre} (stock {pr.stock})
                        </option>
                      ))}
                    </select>
                    <input
                      type="number" min="1"
                      value={linea.cantidad}
                      onChange={(e) => setLinea(idx, 'cantidad', e.target.value)}
                      style={{ ...formStyles.input, padding: '6px 10px', fontSize: '0.85rem', textAlign: 'right' }}
                    />
                    <div style={{ textAlign: 'right', fontSize: '0.85rem', color: palette.textSoft }}>
                      {p ? `Q${Number(p.precio).toFixed(2)}` : '—'}
                    </div>
                    <div style={{ textAlign: 'right', fontSize: '0.85rem', fontWeight: 600 }}>
                      Q{subtotalLinea.toFixed(2)}
                    </div>
                    <button
                      type="button"
                      onClick={() => removeLinea(idx)}
                      disabled={form.items.length === 1}
                      style={{
                        background: 'transparent',
                        border: 'none',
                        color: form.items.length === 1 ? '#D9C0CC' : '#B22222',
                        cursor: form.items.length === 1 ? 'not-allowed' : 'pointer',
                        fontSize: '1.1rem',
                        padding: 0,
                        lineHeight: 1,
                      }}
                    >×</button>
                  </div>
                );
              })}
            </div>
            <button
              type="button"
              onClick={addLinea}
              style={{
                marginTop: 10,
                background: 'transparent',
                border: `1px dashed ${palette.primary}`,
                color: palette.primary,
                padding: '8px 14px',
                borderRadius: 999,
                cursor: 'pointer',
                fontWeight: 600,
                fontSize: '0.85rem',
              }}
            >+ Agregar producto</button>
          </div>

          <div
            style={{
              marginTop: 22,
              display: 'grid',
              gridTemplateColumns: '1fr auto',
              gap: 14,
              alignItems: 'end',
            }}
          >
            <div style={{ display: 'flex', gap: 10 }}>
              <button type="button" onClick={resetForm} style={formStyles.ghostBtn}>Limpiar</button>
              <button type="submit" disabled={submitting} style={formStyles.primaryBtn}>
                {submitting ? 'Procesando…' : 'Registrar venta'}
              </button>
            </div>
            <div style={{ textAlign: 'right' }}>
              <Linea label="Subtotal" value={`Q${totales.subtotal.toFixed(2)}`} />
              <Linea label="IVA (12%)" value={`Q${totales.impuesto.toFixed(2)}`} />
              <Linea
                label="Total"
                value={`Q${totales.total.toFixed(2)}`}
                strong
              />
            </div>
          </div>
        </form>
      </div>

      <h3 style={{ color: palette.primary, marginBottom: 12 }}>Ventas recientes</h3>
      <div
        style={{
          background: palette.surface,
          border: `1px solid ${palette.border}`,
          borderRadius: 16,
          overflow: 'hidden',
          boxShadow: '0 4px 18px rgba(199, 21, 133, 0.06)',
        }}
      >
        <div style={{ overflowX: 'auto' }}>
          <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
            <thead>
              <tr>
                <Th>Factura</Th>
                <Th>Fecha</Th>
                <Th>Cliente</Th>
                <Th>Sucursal</Th>
                <Th>Método</Th>
                <Th align="right">Total</Th>
                <Th>Estado</Th>
              </tr>
            </thead>
            <tbody>
              {ventas.map((v) => (
                <tr key={v.id_venta} style={{ borderTop: `1px solid ${palette.border}` }}>
                  <Td mono>{v.numero_factura}</Td>
                  <Td>{new Date(v.fecha).toLocaleString('es-GT', { dateStyle: 'medium', timeStyle: 'short' })}</Td>
                  <Td>{v.cliente}</Td>
                  <Td>{v.sucursal}</Td>
                  <Td>{v.metodo_pago}</Td>
                  <Td align="right">Q{Number(v.total).toFixed(2)}</Td>
                  <Td>
                    <span
                      style={{
                        background: v.estado === 'COMPLETADA' ? '#E8F8EE' : palette.errorBg,
                        color: v.estado === 'COMPLETADA' ? '#1F6B3D' : palette.primary,
                        padding: '2px 10px',
                        borderRadius: 999,
                        fontSize: '0.7rem',
                        fontWeight: 700,
                        textTransform: 'uppercase',
                        letterSpacing: 0.5,
                      }}
                    >
                      {v.estado}
                    </span>
                  </Td>
                </tr>
              ))}
              {ventas.length === 0 && (
                <tr>
                  <td colSpan={7} style={{ padding: 24, textAlign: 'center', color: palette.textSoft }}>
                    Aún no hay ventas registradas.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

function Field({ label, required, children }) {
  return (
    <div>
      <label style={formStyles.label}>
        {label}{required && <span style={{ color: palette.primary }}> *</span>}
      </label>
      {children}
    </div>
  );
}

function Linea({ label, value, strong }) {
  return (
    <div
      style={{
        display: 'flex',
        justifyContent: 'space-between',
        gap: 24,
        fontSize: strong ? '1.1rem' : '0.85rem',
        fontWeight: strong ? 800 : 500,
        color: strong ? palette.primary : palette.textSoft,
        padding: '2px 0',
        minWidth: 220,
      }}
    >
      <span>{label}</span>
      <span style={{ color: strong ? palette.primary : palette.text }}>{value}</span>
    </div>
  );
}

function Th({ children, align }) {
  return (
    <th
      style={{
        textAlign: align ?? 'left',
        padding: '12px 14px',
        background: palette.bg,
        color: palette.textSoft,
        fontWeight: 600,
        fontSize: '0.7rem',
        textTransform: 'uppercase',
        letterSpacing: 1,
      }}
    >{children}</th>
  );
}

function Td({ children, align, mono }) {
  return (
    <td
      style={{
        padding: '12px 14px',
        textAlign: align ?? 'left',
        fontFamily: mono ? 'ui-monospace, SFMono-Regular, monospace' : 'inherit',
        verticalAlign: 'middle',
      }}
    >{children}</td>
  );
}
