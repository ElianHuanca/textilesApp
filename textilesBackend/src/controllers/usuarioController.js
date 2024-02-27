const Usuario = require('../models/usuario');
const pool = require('../database/database');

const ObtenerUsuarios = async (req, res) => {
    const usuarios = await Usuario.findAll();
    res.json(usuarios);
};

const ObtenerUsuariosQuery = async (req, res) => {
    try {
        const usuarios = await pool.query('SELECT nombre, correo FROM usuarios');
        res.json(usuarios[0]);
    } catch (error) {
        console.error('Error al obtener usuarios:', error);
        res.status(500).json({ error: 'Error al obtener usuarios', message: error.message });
    }
}

module.exports = {
    ObtenerUsuarios,
    ObtenerUsuariosQuery
}
