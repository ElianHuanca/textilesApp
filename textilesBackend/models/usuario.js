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
    },
    correo: {
        type: DataTypes.STRING,        
    },
    password: {
        type: DataTypes.STRING,        
    },
    token:{
        type: DataTypes.TEXT,            
    }
}, {
    timestamps: false, 
});



module.exports = Usuario;

