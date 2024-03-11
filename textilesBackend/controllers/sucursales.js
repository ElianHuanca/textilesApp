const pool = require('../database/database');
const Sucursal = require('../models/sucursal');

const ObtenerSucursales = async (req, res) => {
    try {
        const { idusuarios } = req.params;
        const sucursales = await Sucursal.findAll({ where: { idusuarios } });
        res.json(sucursales);
    } catch (error) {
        console.error('Error al obtener sucursales:', error);
        res.status(500).json({ error: 'Error al obtener sucursales', message: error.message });
    }    
};

const RegistrarSucursal = async (req, res) => {
    try {
        const { idusuarios } = req.params;
        const { nombre } = req.body;        
        const nuevaSucursal = await Sucursal.create({ idusuarios, nombre });
        res.json(nuevaSucursal);
    } catch (error) {
        console.error('Error al registrar sucursal:', error);
        res.status(500).json({ error: 'Error al registrar sucursal', message: error.message });
    }

}

const ActualizarSucursal = async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre } = req.body;            
        const sucursal = await Sucursal.update({ nombre }, {where: { id }});
        
        if (sucursal == 1) {            
            res.status(200).json({message:'Sucursal Actualizado Correctamente'} );            
        } else {
            res.status(404).json({ error: 'No se encontró la sucursal' });
        }  
    } catch (error) {
        console.error('Error al actualizar sucursal:', error);
        res.status(500).json({ error: 'Error al actualizar sucursal', message: error.message });
    }
}


const EliminarSucursal = async (req, res) => {
    try {
        const { id } = req.params;
        const sucursal = await Sucursal.destroy({ where: { id } });
        if (sucursal == 1) {
            res.json({ message: 'Sucursal eliminada correctamente' });            
        }else{
            res.status(404).json({ error: 'No se encontró la sucursal' });
        }        
    } catch (error) {
        console.error('Error al eliminar sucursal:', error);
        res.status(500).json({ error: 'Error al eliminar sucursal', message: error.message });
    }
}
module.exports = {
    ObtenerSucursales,
    RegistrarSucursal,
    ActualizarSucursal,
    EliminarSucursal
}