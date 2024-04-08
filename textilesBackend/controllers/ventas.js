const Venta = require('../models/venta');

const ObtenerVentas = async (req, res) => {
    try {
        const { idsucursales } = req.params;
        const ventas = await Venta.findAll({
            where: { idsucursales },
            order: [['fecha', 'DESC']] 
        });
        res.json(ventas);
    } catch (error) {
        console.error('Error al obtener ventas:', error);
        res.status(500).json({ error: 'Error al obtener ventas', message: error.message });
    }
};

const RegistrarVenta = async (req, res) => {
    try {
        const { idsucursales, fecha } = req.body;

        const ventaExistente = await Venta.findOne({ where: { idsucursales, fecha } });

        if (!ventaExistente) {
            const nuevaVenta = await Venta.create({ idsucursales, fecha });
            return res.json(nuevaVenta);
        }

        return res.json({ message: 'Venta ya creada para esa sucursal y fecha' });
    } catch (error) {
        console.error('Error al crear venta:', error);
        res.status(500).json({ error: 'Error al crear venta', message: error.message });
    }
};


const RegistrarVentaAhora = async (req, res) => {
    try {
        const { idsucursales } = req.params;
        const fechaActual = new Date();        
        const ventaExistente = await Venta.findOne({
            where: {
                idsucursales,
                fecha: fechaActual
            }
        });

        if (!ventaExistente) {
            const nuevaVenta = await Venta.create({ idsucursales, fecha: fechaActual });
            return res.json(nuevaVenta);
        }

        return res.status(404).json({ message: 'Venta ya creada para hoy' });

    } catch (error) {
        console.error('Error al crear venta:', error);
        res.status(500).json({ error: 'Error al crear venta', message: error.message });
    }
};

module.exports = {
    ObtenerVentas,
    RegistrarVenta,
    RegistrarVentaAhora    
}