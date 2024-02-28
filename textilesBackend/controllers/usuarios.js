const Usuario = require('../models/usuario');
const pool = require('../database/database');
const bcryptjs = require('bcryptjs');

const ObtenerUsuarios = async (req, res) => {
    const usuarios = await Usuario.findAll();
    res.json(usuarios);
};

/* const ObtenerUsuariosQuery = async (req, res) => {
    try {
        const usuarios = await pool.query('SELECT nombre, correo FROM usuarios');
        res.json(usuarios[0]);
    } catch (error) {
        console.error('Error al obtener usuarios:', error);
        res.status(500).json({ error: 'Error al obtener usuarios', message: error.message });
    }
} */

const registrarUsuario = async (req, res) => {
    try {
        //res.json(req.body);
        const { nombre, correo, password } = req.body;
        const salt = bcryptjs.genSaltSync();
        const pass = bcryptjs.hashSync( password, salt );
        const nuevoUsuario = await Usuario.create({ nombre, correo, password:pass });
        res.json(nuevoUsuario);
    } catch (error) {
        console.error('Error al registrar usuario:', error);
        res.status(500).json({ error: 'Error al registrar usuario', message: error.message });
    }

};

module.exports = {
    ObtenerUsuarios,
    //ObtenerUsuariosQuery,
    registrarUsuario
}
