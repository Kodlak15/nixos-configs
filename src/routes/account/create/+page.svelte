<script>
	import trailImg from "$lib/assets/images/trail.jpg";
</script>

<div>
	<section class="relative px-6 md:px-24 py-48 overflow-hidden">
		<div
			class="absolute flex justify-center items-center inset-0 max-w-[100vw] min-w-[80rem] overflow-hidden"
		>
			<img src={trailImg} alt="Navbar background" />
		</div>
		<div class="flex flex-col gap-6">
			<form method="POST">
				<div
					class="bg-white relative flex flex-col gap-4 justify-center items-center m-auto px-6 md:px-24 py-24 border-onyx border-2 rounded-xl max-w-screen-md z-20"
				>
					<div class="relative font-dancing-script">
						<h1 class="text-feldgrau text-4xl font-bold">New account:</h1>
					</div>
					<div
						class="flex flex-col md:flex-row justify-center items-center gap-1 md:gap-2 w-full"
					>
						<label
							for="first_name"
							class="flex-1 text-left md:text-right w-full md:w-1/3"
							>First Name:
						</label>
						<input
							type="text"
							name="first_name"
							class="border-onyx border-2 border-solid w-full md:w-2/3"
							required
						/>
					</div>
					<div
						class="flex flex-col md:flex-row justify-center items-center gap-1 md:gap-2 w-full"
					>
						<label
							for="last_name"
							class="flex-1 text-left md:text-right w-full md:w-1/3"
							>Last Name:
						</label>
						<input
							type="text"
							name="last_name"
							class="border-onyx border-2 border-solid w-full md:w-2/3"
							required
						/>
					</div>
					<div
						class="flex flex-col md:flex-row justify-center items-center gap-1 md:gap-2 w-full"
					>
						<label
							for="email"
							class="flex-1 text-left md:text-right w-full md:w-1/3"
							>Email:
						</label>
						<input
							type="text"
							name="email"
							class="border-onyx border-2 border-solid w-full md:w-2/3"
							required
						/>
					</div>
					<div
						class="flex flex-col md:flex-row justify-center items-center gap-1 md:gap-2 w-full"
					>
						<label
							for="password"
							class="flex-1 text-left md:text-right w-full md:w-1/3"
							>Password:
						</label>
						<input
							type="text"
							name="password"
							class="border-onyx border-2 border-solid w-full md:w-2/3"
							required
						/>
					</div>
					<div class="flex flex-row justify-center items-center gap-2 w-full">
						<div class="flex-1 text-center md:text-right">
							<input
								type="submit"
								value="Submit"
								class="p-1 border-onyx border-2 border-solid rounded-lg cursor-pointer"
							/>
						</div>
					</div>
					<div class="flex justify-center items-center">
						<p class="text-center">
							Already have an account? Click <a
								href="/account/login"
								class="text-feldgrau font-bold cursor-pointer hover:opacity-50"
								>here</a
							> to log in!
						</p>
					</div>
				</div>
			</form>
		</div>
	</section>
</div>
