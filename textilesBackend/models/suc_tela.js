const sequelize = require("../database/database");
const { DataTypes } = require('sequelize');
const Sucursal = require('./sucursal');
const Tela = require('./tela');
const SucTela = sequelize.define('suc_telas', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    seleccionado: {
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
    estado: {
        type: DataTypes.BOOLEAN,
        defaultValue: true,
    },
    idtelas: {
        type: DataTypes.INTEGER,
        references: {
            model: Tela, 
            key: 'id'
        }
    }
}, {
    timestamps: false, 
});

SucTela.belongsTo(Sucursal, { foreignKey: 'idsucursales' }); // Establece la relación de clave foránea
SucTela.belongsTo(Tela, { foreignKey: 'idtelas' });
module.exports = SucTela;

