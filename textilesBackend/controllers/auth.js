
const Usuario = require('../models/usuario');

const { generarJWT } = require('../helpers/generar-jwt');
const bcryptjs = require('bcryptjs');

const login = async (req, res) => {
    /* res.json({ message: 'Login' }); */
    try {
        const { correo, password } = req.body;
        const usuario = await Usuario.findOne({ where: { correo } });
        if (!usuario) {
            return res.status(400).json({ error: 'El usuario no existe' });
        }
        const validPassword = bcryptjs.compareSync(password, usuario.password);
        if (!validPassword) {
            return res.status(400).json({ error: 'La contraseña no es válida' });
        }

        const token = await generarJWT( usuario.id);
        usuario.token = token;
        await usuario.save();
        res.json( usuario );
    } catch (error) {
        console.error('Error al iniciar sesión:', error);
        res.status(500).json({ error: 'Error al iniciar sesión', message: error.message });
    }
}

const checkStatus= async(req, res = response) => {
    const token = req.headers.authorization?.replace('Bearer ', '');

  try {
    // Buscar al usuario en la base de datos por el token
    const usuario = await Usuario.findOne({ token });

    if (!usuario) {
      return res.status(401).json({ error: 'Token incorrecto' });
    }

    // Devolver el usuario sin la contraseña
    //const { password, ...userData } = usuario.toObject();
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