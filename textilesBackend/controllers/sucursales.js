const pool = require('../database/database');

const ObtenerSucursales = async (req, res) => {
    try {
        const { idusuarios } = req.params;
        const result = await pool.query('SELECT * FROM sucursales WHERE idusuarios = $1 and estado=true', [idusuarios]);
        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener sucursales:', error);
        res.status(500).json({ error: 'Error al obtener sucursales', message: error.message });
    }
};

const ObtenerSucursal = async (req, res) => {
    try {
        const { id } = req.params;
        const result = await pool.query('SELECT * FROM sucursales WHERE id = $1 and estado=true', [id]);
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al obtener sucursal:', error);
        res.status(500).json({ error: 'Error al obtener sucursal', message: error.message });
    }
};

const RegistrarSucursal = async (req, res) => {
    try {
        const { idusuarios } = req.params;
        const { nombre } = req.body;
        const result = await pool.query('INSERT INTO sucursales (nombre, idusuarios) VALUES ($1, $2) RETURNING *', [nombre, idusuarios]);
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al registrar sucursal:', error);
        res.status(500).json({ error: 'Error al registrar sucursal', message: error.message });
    }
}

const ActualizarSucursal = async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre } = req.body;
        const result = await pool.query('UPDATE sucursales SET nombre = $1 WHERE id = $2 RETURNING *', [nombre, id]);
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al actualizar sucursal:', error);
        res.status(500).json({ error: 'Error al actualizar sucursal', message: error.message });
    }
}


const EliminarSucursal = async (req, res) => {
    try {
        const { id } = req.params;
        const result = await pool.query('UPDATE sucursales SET estado=false WHERE id = $1 RETURNING *', [id]);
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al eliminar sucursal:', error);
        res.status(500).json({ error: 'Error al eliminar sucursal', message: error.message });
    }
}

module.exports = {
    ObtenerSucursales,
    ObtenerSucursal,
    RegistrarSucursal,
    ActualizarSucursal,
    EliminarSucursal
}