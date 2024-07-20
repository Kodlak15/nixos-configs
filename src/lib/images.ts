// Load images needed throughout site
// Find a better way to deal with this???

import peppersImg from "$lib/assets/images/peppers.jpg";
import trailImg from "$lib/assets/images/trail.jpg";

export const productImages: { [key: number]: string } = {
	3: peppersImg as string,
	4: trailImg as string,
};
