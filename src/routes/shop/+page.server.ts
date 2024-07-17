import type { PageServerLoad } from "./$types";
import { getProducts } from "$lib/server/shop";

export const load: PageServerLoad = async () => {
	return {
		products: await getProducts(),
	};
};
