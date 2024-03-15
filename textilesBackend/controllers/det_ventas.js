const DetVenta = require('../models/det_venta');
const Tela = require('../models/tela');
const sequelize = require('../database/database');

const ObtenerDetVentas = async (req, res) => {
    try {
        const { idventas } = req.params;

        const detallesVenta = await DetVenta.findAll({
            where: { idventas },
            include: {
                model: Tela,
                attributes: [], // Excluir todos los atributos de Tela
            },
            attributes: ['id', 'cantidad', 'precio', 'total', 'idtelas', 'idventas', [sequelize.col('tela.nombre'), 'nombre']], // Utilizar sequelize.col para referenciar el nombre de la tela
            order: [['id', 'DESC']],
            raw: true // Obtener resultados en formato plano (JSON)
        });



        res.json(detallesVenta);
    } catch (error) {
        console.error('Error al obtener detalle venta:', error);
        res.status(500).json({ error: 'Error al obtener detalle venta', message: error.message });
    }
};


const RegistrarDetVentas = async (req, res) => {
    try {
        const { idventas } = req.params;
        const ventas = req.body;
        const detallesVentasCreados = [];
        for (const venta of ventas) {
            const detVenta= await DetVenta.create({
                idventas: idventas,
                idtelas: venta.idtelas,
                cantidad: venta.cantidad,
                precio: venta.precio,
                total: venta.total
            });
            detVenta.nombre = venta.nombre;
            detallesVentasCreados.push(detVenta); 
        }        
        res.status(200).json(detallesVentasCreados);
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