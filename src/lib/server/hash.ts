import bcrypt from "bcrypt";

export async function hashPassword(password: string): Promise<string> {
	const hash = await bcrypt.hash(password, 10);
	return hash;
}

export async function checkPassword(password: string, hash: string): Promise<boolean> {
	const isValidPassword = await bcrypt.compare(password, hash);
	return isValidPassword;
}
