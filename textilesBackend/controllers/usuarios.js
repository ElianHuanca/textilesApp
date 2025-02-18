const bcryptjs = require('bcryptjs');
const pool = require('../database/database');

const ObtenerUsuarios = async (req, res) => {
    try {
        const results = await pool.query('SELECT * FROM usuarios WHERE estado = true');
        res.json(results.rows);
    } catch (error) {
        console.error('Error al obtener los usuarios:', error);
        res.status(500).json({ error: 'Error al obtener los usuarios' });
    }
}


const obtenerUsuario = async (req, res) => {
    try {
        const { id } = req.params;
        const result = await pool.query('SELECT * from usuarios WHERE id = $1 and estado = true', [id]);
        return res.json(result.rows);
    } catch (error) {
        console.log('Error:', error);
        res.status(500).json({ error: "Error al obtener Usuario", message: error.message });
    }
}


const registrarUsuario = async (req, res) => {
    try {
        const { nombre, correo, password } = req.body;
        const salt = bcryptjs.genSaltSync();
        const pass = bcryptjs.hashSync(password, salt);
        const result = await pool.query('INSERT INTO usuarios (nombre, correo, password) VALUES ($1, $2, $3) RETURNING *', [nombre, correo, pass]);
        res.json(result.rows);
    } catch (error) {
        console.error('Error al registrar usuario:', error);
        res.status(500).json({ error: 'Error al registrar usuario', message: error.message });
    }

};

const actualizarUsuario = async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre, correo, password } = req.body;
        const salt = bcryptjs.genSaltSync();
        const pass = bcryptjs.hashSync(password, salt);        
        const result = await pool.query('UPDATE usuarios SET nombre = $1, correo = $2, password = $3 WHERE id = $4', [nombre,correo, pass, id]);
        res.status(200).json(result.rows);
    } catch (error) {
        res.status(500).json({ error: 'Error al actualizar usuario', message: error.message });
    }
}

module.exports = {
    ObtenerUsuarios,
    obtenerUsuario,
    registrarUsuario,
    actualizarUsuario
}
