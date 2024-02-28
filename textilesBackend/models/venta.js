const sequelize = require("../database/database");
const { DataTypes } = require('sequelize');
const Sucursal = require('./sucursal');

const Venta = sequelize.define('ventas', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    fecha:{
        type: DataTypes.DATE,        
    },
    total:{
        type: DataTypes.FLOAT,
    },
    ganancias:{
        type: DataTypes.FLOAT,        
    },
    idsucursales: {
        type: DataTypes.INTEGER,
        references: {
            model: Sucursal, 
            key: 'id'
        }
    },
}, {
    timestamps: false, 
});

Venta.belongsTo(Sucursal, { foreignKey: 'idsucursales' }); 

module.exports = Venta;

