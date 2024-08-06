import pkg from "pg";
const { Pool } = pkg;
import dotenv from "dotenv";

// Load environment variables from .env
dotenv.config();

// Docker Postgres (uncomment for dev)
// export const pool = new Pool({
// 	user: "postgres",
// 	// host: "172.19.0.1",
// 	host: "127.0.0.1",
// 	// host: "0.0.0.0",
// 	// database: "cascade-botanicals",
// 	database: "postgres",
// 	password: "example",
// 	port: 5432,
// });

// FIXME: cannot connect to postgres on test VM
// Error: Cross-site POST form submissions are forbidden :( whyyyyyyyyyyyyyyyyyyyyyy
export const pool = new Pool({
	user: "postgres",
	host: "192.168.122.142", // Why is the request going to the application vm?
	database: "postgres",
	password: "example",
	port: 5432,
});

// Vercel Postgres (uncomment for production)
// export const pool = new Pool({
// 	connectionString: process.env.POSTGRES_URL,
// });
