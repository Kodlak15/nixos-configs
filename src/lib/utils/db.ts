import pkg from "pg";
const { Pool } = pkg;
import dotenv from "dotenv";

// Load environment variables from .env
dotenv.config();

export const pool = new Pool({
	connectionString: process.env.POSTGRES_URL,
});
