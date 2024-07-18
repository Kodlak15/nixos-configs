<script lang="ts">
	export let productId: number;
	export let buttonId: string; // TODO This name is somewhat deceiving (element is a form)

	export let color: string | undefined;
	if (!color) {
		color = "white";
	}

	// TODO would be best to find way to limit options for this
	export let operation: string;

	async function updateCartWidget(quantity: number) {
		const itemsInCart = document.getElementById("items-in-cart");
		if (!itemsInCart) {
			console.log("Unable to update UI: Missing items-in-cart widget");
			return;
		}

		itemsInCart.innerText = quantity.toString();
	}

	// TODO stupid stupid naming
	// This should get the number of items for this product, not the total number
	async function updateCartWidgetProduct(quantity: number, productId: string) {
		const spans = document.getElementsByClassName(
			"num-cart-items-" + productId,
		);

		for (let i = 0; i < spans.length; i++) {
			const span = spans[i] as HTMLElement;
			span.innerText = quantity.toString();
		}
	}

	async function addToCart(event: SubmitEvent) {
		const form = document.getElementById(
			"add-to-cart-" + productId,
		) as HTMLFormElement;

		event.preventDefault();
		const formData = new FormData(form);

		try {
			const response = await fetch(form.action, {
				method: "POST",
				body: formData,
			});

			if (response.ok) {
				const result = await response.json();
				const json = JSON.parse(result.data);

				const quantityTotalIdx = json[0]["quantityTotal"];
				const quantityProductIdx = json[0]["quantityProduct"];
				const quantityTotal = JSON.parse(result.data)[quantityTotalIdx];
				const quantityProduct = JSON.parse(result.data)[quantityProductIdx];
				console.log("Total:", quantityTotal);
				console.log("Product:", quantityProduct);
				updateCartWidget(quantityTotal);
				updateCartWidgetProduct(quantityProduct, productId.toString());
			} else {
				console.log("Failed to add item to cart");
			}
		} catch (error) {
			console.error("Error:", error);
		}
	}

	async function removeFromCart(event: SubmitEvent) {
		const form = document.getElementById(
			"remove-from-cart-" + productId,
		) as HTMLFormElement;

		event.preventDefault();
		const formData = new FormData(form);

		try {
			const response = await fetch(form.action, {
				method: "POST",
				body: formData,
			});

			if (response.ok) {
				const result = await response.json();
				const json = JSON.parse(result.data);

				const quantityTotalIdx = json[0]["quantityTotal"];
				const quantityProductIdx = json[0]["quantityProduct"];
				const quantityTotal = JSON.parse(result.data)[quantityTotalIdx];
				const quantityProduct = JSON.parse(result.data)[quantityProductIdx];
				console.log(result.data);
				console.log("Total:", quantityTotal);
				console.log("Product:", quantityProduct);
				updateCartWidget(quantityTotal);
				updateCartWidgetProduct(quantityProduct, productId.toString());
			} else {
				console.log("Failed to remove item from cart");
			}
		} catch (error) {
			console.error("Error:", error);
		}
	}
</script>

{#if operation === "sub"}
	<form
		id={buttonId}
		action={"/shop/" + productId + "?/removeFromCart"}
		method="POST"
		on:submit={async (event) => await removeFromCart(event)}
	>
		<div
			class="relative border-2 border-transparent border-solid rounded-full hover:cursor-pointer hover:border-black z-50"
		>
			<input
				type="submit"
				value=""
				class="absolute top-0 left-0 w-full h-full hover:cursor-pointer"
			/>
			<svg
				xmlns="http://www.w3.org/2000/svg"
				viewBox="0 0 512 512"
				class={"fill-" + color + " w-6 h-6"}
			>
				<!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path
					d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM184 232l144 0c13.3 0 24 10.7 24 24s-10.7 24-24 24l-144 0c-13.3 0-24-10.7-24-24s10.7-24 24-24z"
				/>
			</svg>
		</div>
	</form>
{:else}
	<form
		id={buttonId}
		class={"add-to-cart-" + productId}
		action={"/shop/" + productId + "?/addToCart"}
		method="POST"
		on:submit={async (event) => await addToCart(event)}
	>
		<div
			class="relative border-2 border-transparent border-solid rounded-full hover:cursor-pointer hover:border-black z-50"
		>
			<input
				type="submit"
				value=""
				class={"absolute top-0 left-0 w-full h-full hover:cursor-pointer"}
			/>
			<svg
				xmlns="http://www.w3.org/2000/svg"
				viewBox="0 0 512 512"
				class={"fill-" + color + " w-6 h-6"}
			>
				<!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
				<path
					d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM232 344V280H168c-13.3 0-24-10.7-24-24s10.7-24 24-24h64V168c0-13.3 10.7-24 24-24s24 10.7 24 24v64h64c13.3 0 24 10.7 24 24s-10.7 24-24 24H280v64c0 13.3-10.7 24-24 24s-24-10.7-24-24z"
				/>
			</svg>
		</div>
	</form>
{/if}
