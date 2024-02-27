const sequelize = require("../database/database");
const { DataTypes } = require('sequelize');
const Usuario = require('./usuario');

const Tela = sequelize.define('telas', {
    id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    nombre: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    precxmen: {
        type: DataTypes.FLOAT,
        allowNull: false,
    },
    precxmay: {
        type: DataTypes.FLOAT,
        allowNull: false,
    },    
    precxrollo: {
        type: DataTypes.FLOAT,
        allowNull: false,
    },
    precxcompra: {
        type: DataTypes.FLOAT,
        allowNull: false,
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

Tela.belongsTo(Usuario, { foreignKey: 'idusuarios' }); 

module.exports = Tela;

