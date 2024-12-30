import { Pool } from 'pg';

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'asky',
    password: 'Vignesh',
    port: 5432,
});

export default pool;
