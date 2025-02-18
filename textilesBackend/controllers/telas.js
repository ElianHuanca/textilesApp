const pool = require('../database/database');

const ObtenerTelasXUsu = async (req, res) => {
    try {        
        const { idusuarios } = req.params;
        const result = await pool.query('SELECT * FROM telas WHERE idusuarios = $1 and estado=true ORDER BY nombre ', [idusuarios]);
        res.json(result.rows);
    } catch (error) {
        console.error('Error al obtener telas:', error);
        res.status(500).json({ error: 'Error al obtener telas', message: error.message });
    }
};

const ObtenerTela = async (req, res) => {
    try {
        const { id } = req.params;
        const result = await pool.query('SELECT * FROM telas WHERE id = $1 and estado=true', [id]);
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al obtener tela:', error);
        res.status(500).json({ error: 'Error al obtener tela', message: error.message });
    }
};

const RegistrarTela = async (req, res) => {
    try {
        const { idusuarios } = req.params;
        const { nombre, precxmen, precxmay, precxrollo, precxcompra } = req.body;
        const result = await pool.query('INSERT INTO telas (idusuarios, nombre, precxmen, precxmay, precxrollo, precxcompra) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *', [idusuarios, nombre, precxmen, precxmay, precxrollo, precxcompra]);
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al registrar tela:', error);
        res.status(500).json({ error: 'Error al registrar tela', message: error.message });
    }
};

const ActualizarTela = async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre, precxmen, precxmay, precxrollo, precxcompra } = req.body;        
        const result = await pool.query('UPDATE telas SET nombre = $1, precxmen = $2, precxmay = $3, precxrollo = $4, precxcompra = $5 WHERE id = $6 RETURNING *', [nombre, precxmen, precxmay, precxrollo, precxcompra, id]);
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al actualizar tela:', error);
        res.status(500).json({ error: 'Error al actualizar tela', message: error.message });
    }
}

const EliminarTela = async (req, res) => {
    try {
        const { id } = req.params;
        const result = await pool.query('UPDATE telas SET estado=false WHERE id = $1 RETURNING *', [id]);
        res.json(result.rows[0]);
    } catch (error) {
        console.error('Error al eliminar tela:', error);
        res.status(500).json({ error: 'Error al eliminar tela', message: error.message });
    }
}

module.exports = {
    ObtenerTelasXUsu,
    ObtenerTela,
    RegistrarTela,
    ActualizarTela,
    EliminarTela
}