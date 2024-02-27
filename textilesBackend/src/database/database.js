const { Sequelize } = require('sequelize');
require('dotenv').config();
const { Pool } = require('pg');

const database = process.env.DATABASE;
const username = process.env.DB_USERNAME;
const password = process.env.PASSWORD;
const host = process.env.HOST;
const port = process.env.DB_PORT ? process.env.DB_PORT : 5432;

console.log(database, username, password, host);

const sequelize = new Sequelize(database, username, password ,{
    host,
    dialect: 'postgres',
    /* dialectOptions: {
        ssl: {
          require: false,
          rejectUnauthorized: false // <<<<<<< YOU NEED THIS
        }
    }, */
});

const pool = new Pool({
    user: username,
    host: host,
    database: database,
    password: password,
    port: port,
});

module.exports = sequelize,pool;
