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
        ORDER BY det_ventas.id DESC;
        `;
        const response = await pool.query(query, { idventas });
        res.json(response[0]);
    } catch (error) {
        console.error('Error al obtener detalle venta:', error);
        res.status(500).json({ error: 'Error al obtener detalle venta', message: error.message });
    }
};



const RegistrarDetVentas = async (req, res) => {
    try {
        const { idventas } = req.params;
        const ventas = req.body;
        ventas.forEach(async venta => {
            await DetVenta.create({
                idventas: idventas,
                idtelas: venta.idtelas,
                cantidad: venta.cantidad,
                precio: venta.precio,
                total: venta.total
            });
        });
    } catch (error) {
        console.error('Error al registrar detalle venta:', error);
        res.status(500).json({ error: 'Error al registrar detalle venta', message: error.message });
    }
};

const eliminarDetVenta = async (req, res) => {
    try {
        const { id } = req.params;
        await DetVenta.destroy({ where: { id } });
        res.json({ message: 'Detalle de venta eliminado correctamente' });
    } catch (error) {
        console.error('Error al eliminar detalle de venta:', error);
        res.status(500).json({ error: 'Error al eliminar detalle de venta', message: error.message });
    }

}
module.exports = {
    ObtenerDetVentas,
    RegistrarDetVentas,
    eliminarDetVenta
}