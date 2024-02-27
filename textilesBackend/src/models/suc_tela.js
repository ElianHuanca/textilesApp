const sequelize = require("../database/database");
const { DataTypes } = require('sequelize');
const Sucursal = require('./sucursal');
const SucTela = sequelize.define('suc_telas', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    seleccionado: {
        type: DataTypes.BOOLEAN,
        defaultValue: true,
        allowNull: false,
    },
    idsucursales: {
        type: DataTypes.INTEGER,
        references: {
            model: Sucursal, // Nombre del modelo al que se hace referencia
            key: 'id' // Clave primaria del modelo al que se hace referencia
        }
    }
}, {
    timestamps: false, 
});

SucTela.belongsTo(Sucursal, { foreignKey: 'idsucursales' }); // Establece la relación de clave foránea

module.exports = SucTela;

