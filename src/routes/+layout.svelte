<script>
	import "../tailwind.css";
	import logo from "$lib/assets/images/logos/logo.png";
</script>

<nav>
	<div class="bg-feldgrau flex justify-center items-center p-12">
		<a href="/">
			<img src={logo} alt="Cascade Botanicals Logo" width="300" height="300" />
		</a>
	</div>
</nav>
<div>
	<slot />
</div>
<footer></footer>
