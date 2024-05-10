const DetVenta = require('../models/det_venta');
const Tela = require('../models/tela');
const sequelize = require('../database/database');
const Venta = require('../models/venta');

const ObtenerDetVentas = async (req, res) => {
    try {
        const { idventas } = req.params;
        const detallesVenta = await DetVenta.findAll({
            where: { idventas,estado: true},
            include: {
                model: Tela,
                attributes: [],
            },
            attributes: ['id', 'cantidad', 'precio', 'total','ganancias', 'idtelas', 'idventas', [sequelize.col('tela.nombre'), 'nombre']], // Utilizar sequelize.col para referenciar el nombre de la tela
            order: [['id', 'DESC']],
            raw: true 
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
        const data = req.body;       
        const detallesVentasCreados = [];    
        const vta = await Venta.findOne( { where: { id: idventas } } );            
        for (const venta of data.ventas) {
            const detVenta= await DetVenta.create({
                idventas: idventas,
                idtelas: venta.idtelas,
                cantidad: venta.cantidad,
                precio: venta.precio,
                total: venta.total,
                ganancias: venta.ganancias
            });        
               
            detVenta.dataValues.nombre = venta.nombre;      
            vta.total += venta.total;
            vta.ganancias +=  venta.ganancias;      
            detallesVentasCreados.push(detVenta);                         
        }   
        console.log(vta.descuento);           
        vta.descuento +=  data.descuento;
        console.log(vta.descuento);
        await vta.save();
        res.status(200).json(detallesVentasCreados);
    } catch (error) {
        console.error('Error al registrar detalle venta:', error);
        res.status(500).json({ error: 'Error al registrar detalle venta', message: error.message });
    }
};


const eliminarDetVenta = async (req, res) => {
    try {
        const { id } = req.params;
        const detVenta = await DetVenta.findByPk(id);
        const venta = await Venta.findByPk(detVenta.idventas);
        detVenta.estado = false;
        venta.total -= detVenta.total;
        venta.ganancias -= detVenta.ganancias;
        await venta.save();
        await detVenta.save();
        res.status(200).json({ message: 'Detalle de venta eliminado correctamente' });
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