const pool = require('../database/database');

const ObtenerVentas = async (req, res) => {
    try {
        const { idsucursales } = req.params;
        const result = await pool.query('SELECT * FROM ventas WHERE idsucursales = $1 ORDER BY fecha DESC LIMIT 8', [idsucursales]);
        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener ventas:', error);
        res.status(500).json({ error: 'Error al obtener ventas', message: error.message });
    }
};

const ObtenerVenta = async (req, res) => {
    try {
        const { id } = req.params;
        const result = await pool.query('SELECT * FROM ventas WHERE id = $1', [id]);
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al obtener venta:', error);
        res.status(500).json({ error: 'Error al obtener venta', message: error.message });
    }
};

const RegistrarVenta = async (req, res) => {
    try {
        const { idsucursales, fecha } = req.body;
        const result = await pool.query('INSERT INTO ventas (idsucursales, fecha) VALUES ($1, $2) RETURNING *', [idsucursales, fecha]);
        return res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al crear venta:', error);
        res.status(500).json({ error: 'Error al crear venta', message: error.message });
    }
};


const RegistrarVentaAhora = async (req, res) => {
    try {
        const { idsucursales } = req.params;
        const fechaActual = new Date();
        const result = await pool.query('INSERT INTO ventas (idsucursales, fecha) VALUES ($1, $2) RETURNING *', [idsucursales, fechaActual]);
        return res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al crear venta:', error);
        res.status(500).json({ error: 'Error al crear venta', message: error.message });
    }
};

const ActualizarVenta = async (req, res) => {
    try {
        const { id } = req.params;
        const { total, ganancias, descuento } = req.body;

        const { rows } = await pool.query('SELECT total, ganancias, descuento FROM ventas WHERE id = $1', [id]);
        const venta = rows[0];

        const result = await pool.query(
            'UPDATE ventas SET total = $1, ganancias = $2, descuento = $3 WHERE id = $4 RETURNING *',
            [venta.total + total, venta.ganancias + ganancias, venta.descuento + descuento, id]
        );
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al actualizar venta:', error);
        res.status(500).json({ error: 'Error al actualizar venta', message: error.message });
    }
};




module.exports = {
    ObtenerVentas,
    ObtenerVenta,
    RegistrarVenta,    
    RegistrarVentaAhora,
    ActualizarVenta
}