const express  = require('express');
const http     = require('http');
//const socketio = require('socket.io');
const path     = require('path');
const cors     = require('cors');
//const sequelize = require("../database/database");

class Server {

    constructor() {

        this.app  = express();
        this.port = process.env.PORT;
        this.paths = {
            'auth': '/api/auth',
            'usuarios': '/api/usuarios',
            'sucursales': '/api/sucursales',
            'telas': '/api/telas',
            'suc_telas': '/api/suc_telas',
            'ventas': '/api/ventas',
            'det_ventas': '/api/det_ventas',
        };

        // Http server
        this.server = http.createServer( this.app );
            
    }

    middlewares() {
        //para leer jsons
        this.app.use(express.json());
        
        // Desplegar el directorio público
        this.app.use( express.static( path.resolve( __dirname, '../public' ) ) );

        // CORS
        this.app.use( cors() );

        //Routes
        this.app.use(this.paths.auth, require('../routes/auth.routes'));
        this.app.use(this.paths.usuarios, require('../routes/usuarios.routes'));        
        this.app.use(this.paths.sucursales, require('../routes/sucursales.routes'));
        /* this.app.use(this.paths.telas, require('../routes/telas.routes'));
        this.app.use(this.paths.suc_telas, require('../routes/suc_telas.routes'));
        this.app.use(this.paths.ventas, require('../routes/ventas.routes'));
        this.app.use(this.paths.det_ventas, require('../routes/det_ventas.routes')); */
    }    

    async execute(){
        try {
            //await sequelize.sync({ force: false });
            console.log('Connection has been established successfully.');
          } catch (error) {
            console.error('Unable to connect to the database:', error);
        }

        // Inicializar Middlewares
        this.middlewares();

        // Inicializar Server
        this.server.listen( this.port, () => {
            console.log('Server corriendo en puerto:', this.port );
        });
    }

}


module.exports = Server;