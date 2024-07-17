<script lang="ts">
	import "../tailwind.css";
	import Navbar from "$lib/components/Navbar.svelte";
	import Footer from "$lib/components/Footer.svelte";
	import type { PageData } from "./$types";

	export let data: PageData;

	const itemsInCart = data.cart
		? data.cart.reduce((total, item) => total + item.quantity, 0)
		: 0;
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

<!-- itemsInCart={data.itemsInCart ? data.itemsInCart : 0} -->
<Navbar firstName={data.firstName} {itemsInCart} cart={data.cart} />
<slot />
<Footer />
