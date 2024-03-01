const DetVenta = require('../models/det_venta');

const ObtenerDetVentas = async (req, res) => {
    try {
        const { idventas } = req.params;
        const detventas = await DetVenta.findAll({ where: { idventas } });
        res.json(detventas);
    } catch (error) {
        console.error('Error al obtener detalle venta:', error);
        res.status(500).json({ error: 'Error al obtener detalle venta', message: error.message });
    }    
};

const RegistrarDetVentas = async (req, res) => {
    try{
        const {idventas} = req.params;
        const { ventas } = req.body;

        // Aquí puedes procesar la lista de ventas como desees
        ventas.forEach(venta => {
            // Realizar alguna operación con cada venta
            console.log(`Venta${idventas}: idproductos=${venta.idproductos}, cantidad=${venta.cantidad}, precio=${venta.precio}`);
        });


    }catch(error){
        console.error('Error al registrar detalle venta:', error);
        res.status(500).json({ error: 'Error al registrar detalle venta', message: error.message });
    }
};

module.exports = {
    ObtenerDetVentas,
    RegistrarDetVentas
}