const pool = require('../database/database');
const Sucursal = require('../models/sucursal');

const ObtenerSucursalesXUsuario = async (req, res) => {
    try {
        const { idusuarios } = req.params;
        const sucursales = await Sucursal.findAll({ where: { idusuarios } });
        res.json(sucursales);
    } catch (error) {
        console.error('Error al obtener sucursales:', error);
        res.status(500).json({ error: 'Error al obtener sucursales', message: error.message });
    }    
};

const RegistrarSucursalXUsuario = async (req, res) => {
    try {
        const { idusuarios, nombre } = req.body;        
        const nuevaSucursal = await Sucursal.create({ idusuarios, nombre });
        res.json(nuevaSucursal);
    } catch (error) {
        console.error('Error al registrar sucursal:', error);
        res.status(500).json({ error: 'Error al registrar sucursal', message: error.message });
    }

}


module.exports = {
    ObtenerSucursalesXUsuario,
    RegistrarSucursalXUsuario
}