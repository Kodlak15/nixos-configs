<script>
	import trailImg from "$lib/assets/images/trail.jpg";
</script>

<div>
	<section class="relative px-24 py-48">
		<div
			class="absolute flex justify-center items-center inset-0 min-w-[50rem] overflow-hidden"
		>
			<img src={trailImg} alt="Navbar background" />
		</div>
		<div class="relative flex flex-col gap-6 z-50">
			<form method="POST">
				<div
					class="bg-white flex flex-col gap-4 justify-center items-center m-auto p-24 border-onyx border-2 rounded-xl max-w-screen-md"
				>
					<div class="relative font-dancing-script">
						<h1 class="text-feldgrau text-4xl font-bold">Log in:</h1>
					</div>
					<div
						class="flex flex-row justify-center items-center gap-2 m-auto w-full"
					>
						<label for="username" class="flex-1 text-right w-1/3"
							>Username:</label
						>
						<input
							type="text"
							name="username"
							class="border-onyx border-2 border-solid w-2/3"
							required
						/>
					</div>
					<div class="flex flex-row justify-center items-center gap-2 w-full">
						<label for="password" class="flex-1 text-right w-1/3"
							>Password:</label
						>
						<input
							type="text"
							name="password"
							class="border-onyx border-2 border-solid w-2/3"
							required
						/>
					</div>
					<div class="flex flex-row justify-center items-center gap-2 w-full">
						<div class="flex-1 text-right">
							<input
								type="submit"
								value="Submit"
								class="p-1 border-onyx border-2 border-solid rounded-lg cursor-pointer"
							/>
						</div>
					</div>
					<div class="flex justify-center items-center">
						<p>
							Don't have an account? Click <a
								href="/account/create"
								class="text-feldgrau font-bold cursor-pointer hover:opacity-50"
								>here</a
							> to create one!
						</p>
					</div>
				</div>
			</form>
		</div>
	</section>
</div>
