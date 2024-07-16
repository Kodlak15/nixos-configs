<script lang="ts">
	import "../tailwind.css";
	import Navbar from "$lib/components/Navbar.svelte";
	import Footer from "$lib/components/Footer.svelte";

	// TODO figure out how to pull cart data from database on load (for navbar icon)
	// Manage visual state client side after load

	export let data: {
		firstName: string | undefined;
		itemsInCart: string | undefined;
	};
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

<Navbar
	firstName={data.firstName}
	itemsInCart={data.itemsInCart ? data.itemsInCart : "0"}
/>
<slot />
<Footer />
