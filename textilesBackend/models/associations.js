/* const Sucursal = require('./sucursal');
const Venta = require('./venta');
const Tela = require('./tela');
const DetVenta = require('./det_venta');

Sucursal.hasMany(Venta, { foreignKey: 'idsucursales', as: 'Venta' });
Venta.belongsTo(Sucursal, { foreignKey: 'idsucursales', as: 'Sucursal' });
Tela.hasMany(DetVenta, { foreignKey: 'idtelas', as : 'DetVenta' });
DetVenta.belongsTo(Tela, { foreignKey: 'idtelas', as: 'Tela' });

module.exports = { Sucursal, Venta, Tela, DetVenta };
 */