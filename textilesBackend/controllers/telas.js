const Tela = require('../models/tela');

const ObtenerTelasXUsu = async (req, res) => {
    try {
        const { idusuarios } = req.params;
        const telas = await Tela.findAll({ where: { idusuarios } });
        res.json(telas);
    } catch (error) {
        console.error('Error al obtener telas:', error);
        res.status(500).json({ error: 'Error al obtener telas', message: error.message });
    }    
};

module.exports = {
    ObtenerTelasXUsu
}