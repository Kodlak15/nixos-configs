<script>
	import "../tailwind.css";
	import Navbar from "$lib/components/Navbar.svelte";
	import Footer from "$lib/components/Footer.svelte";
</script>

<Navbar />
<div>
	<slot />
</div>
<Footer />
