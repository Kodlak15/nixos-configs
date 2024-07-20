<!-- TODO reconsider data flow strategy -->
<!-- How do I optimally load necessary data and get it to the places it needs to go? -->

<script lang="ts">
	import "../tailwind.css";
	import Navbar from "$lib/components/Navbar.svelte";
	import Footer from "$lib/components/Footer.svelte";
	import type { PageData } from "./$types";

	export let data: PageData;

	const user = data.user;
	const cart = data.cart ? data.cart : [];
	const products = data.products ? data.products : [];
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

<Navbar {user} {cart} {products} />
<slot />
<Footer />
