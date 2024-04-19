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
    },
    precxmen: {
        type: DataTypes.FLOAT,
    },
    precxmay: {
        type: DataTypes.FLOAT,        
    },    
    precxrollo: {
        type: DataTypes.FLOAT,        
    },
    precxcompra: {
        type: DataTypes.FLOAT,        
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

Tela.belongsTo(Usuario, { foreignKey: 'idusuarios' }); 

module.exports = Tela;

