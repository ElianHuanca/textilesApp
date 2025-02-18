/* const sequelize = require("../database/database");
const { DataTypes } = require('sequelize');
const Tela = require('./tela');
const Venta = require('./venta');

const DetVenta = sequelize.define('det_ventas', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    cantidad: {
        type: DataTypes.FLOAT,
    },
    precio: {
        type: DataTypes.FLOAT,
    },
    total:{
        type: DataTypes.FLOAT,
        defaultValue: 0
    },     
    ganancias:{
        type: DataTypes.FLOAT,
        defaultValue: 0
    },    
    estado: {
        type: DataTypes.BOOLEAN,
        defaultValue: true
    },
    idtelas: {
        type: DataTypes.INTEGER,
        references: {
            model: Tela, 
            key: 'id'
        }
    },
    idventas: {
        type: DataTypes.INTEGER,
        references: {
            model: Venta, 
            key: 'id'
        }
    }
}, {
    timestamps: false, 
});

module.exports = DetVenta;

 */