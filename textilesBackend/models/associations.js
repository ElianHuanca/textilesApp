const Sucursal = require('./sucursal');
const Venta = require('./venta');

Sucursal.hasMany(Venta, { foreignKey: 'idsucursales', as: 'Ventas' });
Venta.belongsTo(Sucursal, { foreignKey: 'idsucursales', as: 'Sucursal' });

module.exports = { Sucursal, Venta };
