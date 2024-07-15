<script lang="ts">
	import { onMount } from "svelte";

	export let imgSrc: string;

	onMount(() => {
		const addToCart = document.getElementById("add-to-cart") as HTMLFormElement;
		const removeFromCart = document.getElementById(
			"remove-from-cart",
		) as HTMLFormElement;

		[addToCart, removeFromCart].forEach((form) =>
			form.addEventListener("submit", async (event) => {
				event.preventDefault();
				const formData = new FormData(form);

				try {
					const response = await fetch(form.action, {
						method: "POST",
						body: formData,
					});

					if (response.ok) {
						console.log("Item added to cart");
					} else {
						console.log("Failed to add item to cart");
					}
				} catch (error) {
					console.error("Error:", error);
				}
			}),
		);
	});
</script>

<div
	class="bg-feldgrau relative flex flex-col rounded-xl overflow-hidden
	shadow-sm shadow-feldgrau hover:shadow-black hover:shadow-md transition duration-200"
>
	<div class="relative rounded-t-xl overflow-hidden">
		<img
			src={imgSrc}
			alt=""
			height="350"
			width="350"
			class="w-[350px] h-[350px] object-cover"
		/>
		<div
			id="card-info"
			class="bg-[rgba(0,0,0,0)] hover:bg-[rgba(0,0,0,0.9)] absolute top-0 left-0 flex flex-col
			justify-center items-center gap-2 p-6 w-full h-full transition duration-200"
		>
			<p class="text-white font-dancing-script text-2xl">Product description</p>
		</div>
	</div>
	<div class="text-center flex flex-col gap-2 p-4">
		<div class="bg-feldgrau font-dancing-script text-white h-full">
			<h1 class="text-2xl font-bold">Peppers</h1>
			<h2 class="text-lg font-bold">$5.99</h2>
		</div>
		<div class="flex flex-row justify-center items-center gap-4">
			<form id="remove-from-cart" action="?/addToCart" method="POST">
				<div class="relative hover:cursor-pointer">
					<input
						type="submit"
						value=""
						class="absolute bg-red top-0 left-0 w-full h-full hover:cursor-pointer"
					/>
					<svg
						xmlns="http://www.w3.org/2000/svg"
						viewBox="0 0 512 512"
						class="fill-white w-6 h-6"
					>
						<!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
						<path
							d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM232 344V280H168c-13.3 0-24-10.7-24-24s10.7-24 24-24h64V168c0-13.3 10.7-24 24-24s24 10.7 24 24v64h64c13.3 0 24 10.7 24 24s-10.7 24-24 24H280v64c0 13.3-10.7 24-24 24s-24-10.7-24-24z"
						/>
					</svg>
				</div>
			</form>
			<!-- TODO how do I pass along the name/id of the item in the POST request? -->
			<form id="add-to-cart" action="?/addToCart" method="POST">
				<div class="relative hover:cursor-pointer">
					<input
						type="submit"
						value=""
						class="absolute bg-red top-0 left-0 w-full h-full hover:cursor-pointer"
					/>
					<svg
						xmlns="http://www.w3.org/2000/svg"
						viewBox="0 0 512 512"
						class="fill-white w-6 h-6"
					>
						<!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
						<path
							d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM232 344V280H168c-13.3 0-24-10.7-24-24s10.7-24 24-24h64V168c0-13.3 10.7-24 24-24s24 10.7 24 24v64h64c13.3 0 24 10.7 24 24s-10.7 24-24 24H280v64c0 13.3-10.7 24-24 24s-24-10.7-24-24z"
						/>
					</svg>
				</div>
			</form>
		</div>
	</div>
</div>

<style>
	#card-info > * {
		display: none;
	}

	#card-info:hover > * {
		display: block;
	}
</style>
