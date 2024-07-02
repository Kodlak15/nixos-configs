import { pool } from "$lib/utils/db";
import type { LayoutServerLoad } from "./$types";
import { getUser } from "$lib/utils/user";

export const load: LayoutServerLoad = async ({ cookies }) => {
	const token = cookies.get("session");
	console.log("token:", token);

	if (token) {
		const result = await pool.query("\
			SELECT uid\
			FROM sessions\
			WHERE token = $1 AND expires_at > NOW()", [token]);

		const rows = result.rows;
		console.log("rows:", rows);
		if (rows.length === 1) {
			const user = await getUser(rows[0].uid);
			return {
				firstName: user.firstName
			};
		}
	}
}
