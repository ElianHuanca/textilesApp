const sequelize = require("../database/database");
const { DataTypes } = require('sequelize');
const Usuario = require('./usuario');
const Sucursal = sequelize.define('sucursales', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    nombre: {
        type: DataTypes.STRING,        
    },
    idusuarios: {
        type: DataTypes.INTEGER,
        references: {
            model: Usuario, // Nombre del modelo al que se hace referencia
            key: 'id' // Clave primaria del modelo al que se hace referencia
        }
    }
}, {
    timestamps: false, 
});

Sucursal.belongsTo(Usuario, { foreignKey: 'idusuarios' }); // Establece la relación de clave foránea

module.exports = Sucursal;

