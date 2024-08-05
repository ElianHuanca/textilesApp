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
        defaultValue: DataTypes.NOW       
    },
    total:{
        type: DataTypes.FLOAT,
        defaultValue: 0
    },
    ganancias:{
        type: DataTypes.FLOAT,        
        defaultValue: 0
    },
    descuento:{
        type: DataTypes.FLOAT,
        defaultValue: 0
    },
    estado: {
        type: DataTypes.BOOLEAN,
        defaultValue: true,
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

//Venta.belongsTo(Sucursal, { foreignKey: 'idsucursales' }); 

/* Venta.associate = (models) => {
    Venta.belongsTo(models.Sucursal, { foreignKey: 'idsucursales' });
}; */
module.exports = Venta;

