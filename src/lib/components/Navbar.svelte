<script>
	import logo from "$lib/assets/images/logos/logo.png";
	import bgImg from "$lib/assets/images/pavl-polo-IzsQez6h6WY-unsplash.jpg";
</script>

<nav>
	<section class="bg-white">
		<div class="text-black flex flex-row items-stretch justify-between p-4">
			<div>
				<svg
					xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 448 512"
					width="20"
					height="20"
					><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path
						d="M0 96C0 78.3 14.3 64 32 64H416c17.7 0 32 14.3 32 32s-14.3 32-32 32H32C14.3 128 0 113.7 0 96zM0 256c0-17.7 14.3-32 32-32H416c17.7 0 32 14.3 32 32s-14.3 32-32 32H32c-17.7 0-32-14.3-32-32zM448 416c0 17.7-14.3 32-32 32H32c-17.7 0-32-14.3-32-32s14.3-32 32-32H416c17.7 0 32 14.3 32 32z"
					/></svg
				>
			</div>
			<div class="flex flex-row justify-center items-center gap-4">
				<svg
					xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 448 512"
					width="20"
					height="20"
					><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path
						d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"
					/></svg
				>
				<svg
					xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 576 512"
					width="20"
					height="20"
					><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path
						d="M0 24C0 10.7 10.7 0 24 0H69.5c22 0 41.5 12.8 50.6 32h411c26.3 0 45.5 25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3H170.7l5.4 28.5c2.2 11.3 12.1 19.5 23.6 19.5H488c13.3 0 24 10.7 24 24s-10.7 24-24 24H199.7c-34.6 0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5H24C10.7 48 0 37.3 0 24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"
					/></svg
				>
			</div>
		</div>
	</section>
	<section class="relative overflow-hidden">
		<div class="absolute flex justify-center items-center inset-0">
			<img src={bgImg} alt="Navbar background" />
		</div>
		<div class="relative flex flex-col justify-center items-center p-24 z-50">
			<div>
				<a href="/">
					<div class="bg-[#476530] border-white border-4 rounded-full">
						<img
							src={logo}
							alt="Cascade Botanicals logo"
							width="350"
							height="350"
						/>
					</div>
				</a>
			</div>
		</div>
	</section>
</nav>
