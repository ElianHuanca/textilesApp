const { Pool } = require('postgres-pool');
require('dotenv').config();

const database = process.env.DATABASE;
const username = process.env.DB_USERNAME;
const password = process.env.PASSWORD;
const host = process.env.HOST;
const port = process.env.DB_PORT ? process.env.DB_PORT : 5432;

const pool = new Pool({
  connectionString: `postgres://${username}:${password}@${host}:${port}/${database}`,
  ssl: {
    require: false,
    rejectUnauthorized: false 
  }
});

module.exports = pool;
