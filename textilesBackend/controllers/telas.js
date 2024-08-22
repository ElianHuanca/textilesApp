const Tela = require('../models/tela');

const ObtenerTelasXUsu = async (req, res) => {
    try {
        const { idusuarios } = req.params;
        const telas = await Tela.findAll({
            where: { idusuarios },
            order: [['nombre', 'ASC']] 
        });
        res.json(telas);
    } catch (error) {
        console.error('Error al obtener telas:', error);
        res.status(500).json({ error: 'Error al obtener telas', message: error.message });
    }
};

const ObtenerTela = async (req, res) => {
    try {
        const { id } = req.params;
        const tela = await Tela.findOne({ where: { id } });
        if (tela) {
            res.json(tela);
        } else {
            res.status(404).json({ error: 'No se encontró la tela' });
        }
    } catch (error) {
        console.error('Error al obtener tela:', error);
        res.status(500).json({ error: 'Error al obtener tela', message: error.message });
    }
};

const RegistrarTela = async (req, res) => {
    try {
        const { idusuarios } = req.params;
        const { nombre, precxmen, precxmay, precxrollo, precxcompra } = req.body;
        const tela = await Tela.create({ idusuarios, nombre, precxmen, precxmay, precxrollo, precxcompra });
        res.json(tela);
    } catch (error) {
        console.error('Error al registrar tela:', error);
        res.status(500).json({ error: 'Error al registrar tela', message: error.message });
    }
};

const ActualizarTela = async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre, precxmen, precxmay, precxrollo, precxcompra } = req.body;
        const tela = await Tela.update({ nombre, precxmen, precxmay, precxrollo, precxcompra }, { where: { id } });
        if (tela == 1) {
            res.json({ message: 'Tela actualizada correctamente' });
        } else {
            res.status(404).json({ error: 'No se encontró la tela' });
        }
    } catch (error) {
        console.error('Error al actualizar tela:', error);
        res.status(500).json({ error: 'Error al actualizar tela', message: error.message });
    }
}

const EliminarTela = async (req, res) => {
    try {
        const { id } = req.params;
        const tela = await Tela.destroy({ where: { id } });
        if (tela == 1) {
            res.json({ message: 'Tela eliminada correctamente' });
        } else {
            res.status(404).json({ error: 'No se encontró la tela' });
        }
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