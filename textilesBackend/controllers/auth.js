const Usuario = require('../models/usuario');
const pool = require('../database/database');
const { generarJWT } = require('../helpers/generar-jwt');
const bcryptjs = require('bcryptjs');

const login = async (req, res) => {    
    try {
        const { correo, password } = req.body;
        const result = await pool.query('SELECT * FROM usuarios WHERE correo = $1', [correo]);
        usuario = result.rows[0];
        if (!usuario) {
            return res.status(400).json({ error: 'El usuario no existe' });
        }
        const validPassword = bcryptjs.compareSync(password, usuario.password);
        if (!validPassword) {
            return res.status(400).json({ error: 'La contraseña no es válida' });
        }
        const token = await generarJWT( usuario.id);
        usuario.token = token;      
        await pool.query('UPDATE usuarios SET token = $1 WHERE id = $2', [token, usuario.id]);
        res.json( usuario );
    } catch (error) {
        console.error('Error al iniciar sesión:', error);
        res.status(500).json({ error: 'Error al iniciar sesión', message: error.message });
    }
}

const checkStatus= async(req, res = response) => {
    const token = req.headers.authorization?.replace('Bearer ', '');

  try {
    
    const result = await pool.query('SELECT * FROM usuarios WHERE token = $1', [token]);
    const usuario = result.rows[0];
    if (!usuario) {
      return res.status(401).json({ error: 'Token incorrecto' });
    }

    res.json(usuario);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error en el servidor' });
  }
}

module.exports = {
    login,
    checkStatus
}