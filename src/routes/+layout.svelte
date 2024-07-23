<script lang="ts">
	import "../tailwind.css";
	import Navbar from "$lib/components/Navbar.svelte";
	import Footer from "$lib/components/Footer.svelte";
	import type { PageData } from "./$types";
	import { setContext } from "svelte";
	import { user, cart, products } from "$lib/stores";

	export let data: PageData;

	$: user.set(data.user);
	setContext("user", user);

	$: cart.set(data.cart ? data.cart : []);
	setContext("cart", cart);

	$: products.set(data.products ? data.products : []);
	setContext("products", products);
</script>

<svelte:head>
	<link rel="preconnect" href="https://fonts.googleapis.com" />
	<link
		rel="preconnect"
		href="https://fonts.gstatic.com"
		crossorigin="anonymous"
	/>
	<link
		href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400..700&family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap"
		rel="stylesheet"
	/>
</svelte:head>

<Navbar />
<slot />
<Footer />
