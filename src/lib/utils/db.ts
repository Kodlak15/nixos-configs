import pkg from "pg";
const { Pool } = pkg;
import dotenv from "dotenv";

// Load environment variables from .env
dotenv.config();

// Docker Postgres (uncomment for dev)
export const pool = new Pool({
	user: "postgres",
	host: "172.19.0.1",
	database: "cascade-botanicals",
	password: "example",
	port: 5432,
});

// Vercel Postgres (uncomment for production)
// export const pool = new Pool({
// 	connectionString: process.env.POSTGRES_URL,
// });
