const sequelize = require("../database/database");
const { DataTypes } = require('sequelize');

const Usuario = sequelize.define('usuarios', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    nombre: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    correo: {
        type: DataTypes.STRING,
        allowNull: false,
    }
}, {
    timestamps: false, 
});


module.exports = Usuario;

