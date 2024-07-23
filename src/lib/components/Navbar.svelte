<script lang="ts">
	import logo from "$lib/assets/images/logos/logo.png";
	import Hamburger from "$lib/components/Hamburger.svelte";
	import CartPopup from "$lib/components/CartPopup.svelte";
	import type { User } from "$lib/types";
	import { toggleNavmenu, toggleCartPopup } from "$lib/ui";
	import { getContext } from "svelte";
	import type { Writable } from "svelte/store";
	import { numItemsInCart } from "$lib/stores";

	const user: Writable<User> = getContext("user");
</script>

<nav class="relative font-dancing-script z-60">
	<div
		class="relative bg-white text-black flex flex-row justify-between items-center p-6"
	>
		<div class="flex-1">
			<Hamburger />
		</div>
		<div class="relative flex flex-1 flex-col justify-center items-center z-50">
			<div>
				<a href="/" class="hover:opacity-100">
					<div class="bg-[#476530] border-white border-4 rounded-full">
						<img
							src={logo}
							alt="Cascade Botanicals logo"
							width="100"
							height="100"
						/>
					</div>
				</a>
			</div>
		</div>
		<CartPopup />
		<div class="relative flex flex-1 justify-end items-center">
			<!-- TODO cart popup here -->
			<!-- <CartPopup /> -->
			<div class="relative flex flex-row justify-center items-center gap-4">
				<div class="hidden md:flex md:flex-row md:gap-4">
					{#if user !== undefined}
						<div class="flex flex-col justify-center items-end">
							<h1 class="text-feldgrau text-xl font-bold">
								<a href="/account/create">User: {$user.firstName}</a>
							</h1>
							<form action="/account/logout" method="POST">
								<input
									type="submit"
									value="Log out"
									class="text-feldgrau text-md font-bold hover:cursor-pointer"
								/>
							</form>
						</div>
					{:else}
						<h1 class="text-feldgrau text-xl font-bold">
							<a href="/account/create">Create Account</a>
						</h1>
						<h1 class="text-feldgrau text-xl font-bold">
							<a href="/account/login">Log In</a>
						</h1>
					{/if}
				</div>
				<div class="relative flex flex-col justify-center items-center gap-2">
					<div
						id="items-in-cart"
						class={"num-cart-items text-[0.6rem] font-noto-sans bg-red-700 text-white text-center absolute top-[-0.5rem] right-[-0.5rem] p-[0.1rem] w-[3ch] rounded-full"}
					>
						{$numItemsInCart}
					</div>
					<button on:click={toggleCartPopup}>
						<div class="bg-feldgrau p-1.5 rounded-full">
							<svg
								xmlns="http://www.w3.org/2000/svg"
								viewBox="0 0 576 512"
								width="15"
								height="15"
								fill="#ffffff"
								><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path
									d="M0 24C0 10.7 10.7 0 24 0H69.5c22 0 41.5 12.8 50.6 32h411c26.3 0 45.5 25 38.6 50.4l-41 152.3c-8.5 31.4-37 53.3-69.5 53.3H170.7l5.4 28.5c2.2 11.3 12.1 19.5 23.6 19.5H488c13.3 0 24 10.7 24 24s-10.7 24-24 24H199.7c-34.6 0-64.3-24.6-70.7-58.5L77.4 54.5c-.7-3.8-4-6.5-7.9-6.5H24C10.7 48 0 37.3 0 24zM128 464a48 48 0 1 1 96 0 48 48 0 1 1 -96 0zm336-48a48 48 0 1 1 0 96 48 48 0 1 1 0-96z"
								/>
							</svg>
						</div>
					</button>
				</div>
				<!-- TODO alternate cart popup here (maybe, idk) -->
			</div>
		</div>
	</div>
	<button class="cursor-auto" on:click={() => toggleNavmenu()}>
		<div
			id="navmenu"
			class="bg-white fixed top-0 left-0 bottom-0 flex justify-center items-center border-b-feldgrau border-solid border-b-8 w-full z-[99] transition duration-500 translate-y-[-100%]"
		>
			<ul
				class="text-4xl text-feldgrau font-bold flex flex-col justify-center items-center gap-4"
			>
				<li><a href="/">Home</a></li>
				<li><a href="/shop">Shop</a></li>
				{#if user !== undefined}
					<li><a href="/account/login">Account</a></li>
				{:else}
					<li><a href="/account/login">Log In</a></li>
					<li><a href="/account/create">Create Account</a></li>
				{/if}
			</ul>
		</div>
	</button>
</nav>
