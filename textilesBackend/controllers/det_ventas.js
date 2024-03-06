const DetVenta = require('../models/det_venta');
const Tela = require('../models/tela');
const pool = require('../database/database');
const ObtenerDetVentas = async (req, res) => {
    try {
        const { idventas } = req.params;
        const query = `
            SELECT det_ventas.*, telas.nombre
            FROM det_ventas
            INNER JOIN telas ON det_ventas.idtelas = telas.id
            WHERE det_ventas.idventas = @idventas
        `;
        const response = await pool.query(query,{idventas});
        res.json(response[0]);
    } catch (error) {
        console.error('Error al obtener detalle venta:', error);
        res.status(500).json({ error: 'Error al obtener detalle venta', message: error.message });
    }
};



const RegistrarDetVentas = async (req, res) => {
    try {
        const { idventas } = req.params;
        const { ventas } = req.body;

        // Aquí puedes procesar la lista de ventas como desees
        ventas.forEach(venta => {
            // Realizar alguna operación con cada venta
            console.log(`Venta${idventas}: idproductos=${venta.idproductos}, cantidad=${venta.cantidad}, precio=${venta.precio}`);
        });


    } catch (error) {
        console.error('Error al registrar detalle venta:', error);
        res.status(500).json({ error: 'Error al registrar detalle venta', message: error.message });
    }
};

module.exports = {
    ObtenerDetVentas,
    RegistrarDetVentas
}