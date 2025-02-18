/* const sequelize = require("../database/database");
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
    estado: {
        type: DataTypes.BOOLEAN,
        defaultValue: true,
    },
    idusuarios: {
        type: DataTypes.INTEGER,
        references: {
            model: Usuario,
            key: 'id'
        }
    }
}, {
    timestamps: false, 
});


module.exports = Sucursal;

 */