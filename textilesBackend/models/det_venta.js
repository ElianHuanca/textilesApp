const sequelize = require("../database/database");
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

DetVenta.belongsTo(Tela, { foreignKey: 'idtelas' });
DetVenta.belongsTo(Venta, { foreignKey: 'idventas' });

module.exports = DetVenta;

