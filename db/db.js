const { Pool } = require('pg');

const pool = new Pool({
  user: '',
  password: '',
  host: 'localhost',
  port: 5432,
  database: 'products',
});

module.exports = pool;