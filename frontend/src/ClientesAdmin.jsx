import { useEffect, useState } from 'react';
import { api, palette } from './api.js';
import { ErrorBanner, SuccessBanner, Modal, formStyles } from './Layout.jsx';
import { PageHeader } from './ProductosAdmin.jsx';

const emptyForm = {
  nombres: '',
  apellidos: '',
  nit: '',
  telefono: '',
  email: '',
  direccion: '',
};

export default function ClientesAdmin() {
  const [clientes, setClientes] = useState([]);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);
  const [modal, setModal] = useState({ open: false, mode: 'create', form: emptyForm });
  const [submitting, setSubmitting] = useState(false);

  async function load() {
    try {
      setClientes(await api('/clientes'));
    } catch (err) {
      setError(err.message);
    }
  }

  useEffect(() => { load(); }, []);

  function openCreate() { setModal({ open: true, mode: 'create', form: emptyForm }); }
  function openEdit(c) {
    setModal({
      open: true,
      mode: 'edit',
      form: {
        id_cliente: c.id_cliente,
        nombres: c.nombres ?? '',
        apellidos: c.apellidos ?? '',
        nit: c.nit ?? '',
        telefono: c.telefono ?? '',
        email: c.email ?? '',
        direccion: c.direccion ?? '',
      },
    });
  }
  function closeModal() { setModal((m) => ({ ...m, open: false })); }
  function setField(name, value) { setModal((m) => ({ ...m, form: { ...m.form, [name]: value } })); }

  async function handleSubmit(e) {
    e.preventDefault();
    setSubmitting(true);
    setError(null);
    try {
      const payload = {
        nombres: modal.form.nombres,
        apellidos: modal.form.apellidos,
        nit: modal.form.nit || null,
        telefono: modal.form.telefono || null,
        email: modal.form.email || null,
        direccion: modal.form.direccion || null,
      };
      if (modal.mode === 'create') {
        await api('/clientes', { method: 'POST', body: JSON.stringify(payload) });
        setSuccess('Cliente creado correctamente');
      } else {
        await api(`/clientes/${modal.form.id_cliente}`, {
          method: 'PUT',
          body: JSON.stringify(payload),
        });
        setSuccess('Cliente actualizado correctamente');
      }
      closeModal();
      await load();
    } catch (err) {
      setError(err.message);
    } finally {
      setSubmitting(false);
    }
  }

  async function handleDelete(c) {
    if (!confirm(`¿Eliminar al cliente "${c.nombres} ${c.apellidos}"?`)) return;
    setError(null);
    try {
      await api(`/clientes/${c.id_cliente}`, { method: 'DELETE' });
      setSuccess('Cliente eliminado');
      await load();
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <div>
      <PageHeader
        title="Clientes"
        subtitle={`${clientes.length} clientes activos`}
        action={<button onClick={openCreate} style={formStyles.primaryBtn}>+ Nuevo cliente</button>}
      />

      <ErrorBanner error={error} onClose={() => setError(null)} />
      <SuccessBanner message={success} onClose={() => setSuccess(null)} />

      <div style={cardStyle}>
        <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
          <thead>
            <tr>
              <Th>Nombre</Th>
              <Th>NIT</Th>
              <Th>Teléfono</Th>
              <Th>Email</Th>
              <Th>Acciones</Th>
            </tr>
          </thead>
          <tbody>
            {clientes.map((c) => (
              <tr key={c.id_cliente} style={{ borderTop: `1px solid ${palette.border}` }}>
                <Td>
                  <div style={{ fontWeight: 600 }}>{c.nombres} {c.apellidos}</div>
                  <div style={{ fontSize: '0.75rem', color: palette.textSoft }}>{c.direccion}</div>
                </Td>
                <Td mono>{c.nit ?? <span style={{ color: '#B89DAB' }}>CF</span>}</Td>
                <Td mono>{c.telefono ?? '—'}</Td>
                <Td>{c.email ?? '—'}</Td>
                <Td>
                  <button onClick={() => openEdit(c)} style={linkBtn}>Editar</button>
                  <button onClick={() => handleDelete(c)} style={{ ...linkBtn, color: '#B22222' }}>Eliminar</button>
                </Td>
              </tr>
            ))}
            {clientes.length === 0 && (
              <tr>
                <Td colSpan={5}>
                  <div style={{ textAlign: 'center', padding: 24, color: palette.textSoft }}>
                    No hay clientes activos.
                  </div>
                </Td>
              </tr>
            )}
          </tbody>
        </table>
      </div>

      <Modal
        open={modal.open}
        onClose={closeModal}
        title={modal.mode === 'create' ? 'Nuevo cliente' : 'Editar cliente'}
      >
        <form onSubmit={handleSubmit}>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12 }}>
            <Field label="Nombres" required>
              <input
                required
                value={modal.form.nombres}
                onChange={(e) => setField('nombres', e.target.value)}
                style={formStyles.input}
              />
            </Field>
            <Field label="Apellidos" required>
              <input
                required
                value={modal.form.apellidos}
                onChange={(e) => setField('apellidos', e.target.value)}
                style={formStyles.input}
              />
            </Field>
          </div>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12 }}>
            <Field label="NIT">
              <input
                value={modal.form.nit}
                onChange={(e) => setField('nit', e.target.value)}
                style={formStyles.input}
                placeholder="Opcional (CF si está vacío)"
              />
            </Field>
            <Field label="Teléfono">
              <input
                value={modal.form.telefono}
                onChange={(e) => setField('telefono', e.target.value)}
                style={formStyles.input}
              />
            </Field>
          </div>
          <Field label="Email">
            <input
              type="email"
              value={modal.form.email}
              onChange={(e) => setField('email', e.target.value)}
              style={formStyles.input}
            />
          </Field>
          <Field label="Dirección">
            <textarea
              rows={2}
              value={modal.form.direccion}
              onChange={(e) => setField('direccion', e.target.value)}
              style={{ ...formStyles.input, resize: 'vertical' }}
            />
          </Field>

          <div style={{ display: 'flex', justifyContent: 'flex-end', gap: 10, marginTop: 22 }}>
            <button type="button" onClick={closeModal} style={formStyles.ghostBtn}>Cancelar</button>
            <button type="submit" disabled={submitting} style={formStyles.primaryBtn}>
              {submitting ? 'Guardando…' : 'Guardar'}
            </button>
          </div>
        </form>
      </Modal>
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

function Th({ children, align }) {
  return (
    <th
      style={{
        textAlign: align ?? 'left',
        padding: '12px 14px',
        background: palette.bg,
        color: palette.textSoft,
        fontWeight: 600,
        fontSize: '0.75rem',
        textTransform: 'uppercase',
        letterSpacing: 1,
      }}
    >
      {children}
    </th>
  );
}

function Td({ children, align, mono, colSpan }) {
  return (
    <td
      colSpan={colSpan}
      style={{
        textAlign: align ?? 'left',
        padding: '12px 14px',
        fontFamily: mono ? 'ui-monospace, SFMono-Regular, monospace' : 'inherit',
        verticalAlign: 'middle',
      }}
    >
      {children}
    </td>
  );
}

const cardStyle = {
  background: palette.surface,
  border: `1px solid ${palette.border}`,
  borderRadius: 16,
  overflow: 'hidden',
  boxShadow: '0 4px 18px rgba(199, 21, 133, 0.06)',
};

const linkBtn = {
  background: 'transparent',
  border: 'none',
  color: palette.primary,
  cursor: 'pointer',
  fontWeight: 600,
  fontSize: '0.85rem',
  padding: '4px 8px',
  marginRight: 4,
};
