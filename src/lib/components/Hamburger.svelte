<script>
	function toggleNavMenu() {
		var hamburger = document.getElementById("hamburger");
		var hamburgerTop = document.getElementById("hamburger-top");
		var hamburgerMid = document.getElementById("hamburger-mid");
		var hamburgerBot = document.getElementById("hamburger-bot");
		var navMenu = document.getElementById("nav-menu");

		switch (hamburger?.classList.contains("open")) {
			case true: {
				hamburger.classList.remove("open");
				if (hamburgerTop !== null) {
					hamburgerTop.style.transform = "rotate(0)";
				}
				if (hamburgerMid !== null) {
					hamburgerMid.style.transform = "translateX(0)";
				}
				if (hamburgerBot !== null) {
					hamburgerBot.style.transform = "rotate(0)";
				}
				if (navMenu !== null) {
					navMenu.style.transform = "translateX(100%)";
				}
				break;
			}
			case false: {
				hamburger.classList.add("open");
				if (hamburgerTop !== null) {
					hamburgerTop.style.transform = "rotate(45deg) translateY(20px)";
				}
				if (hamburgerMid !== null) {
					hamburgerMid.style.transform = "translateX(-100%)";
				}
				if (hamburgerBot !== null) {
					hamburgerBot.style.transform = "rotate(-45deg) translateY(-20px)";
				}
				if (navMenu !== null) {
					navMenu.style.transform = "translateX(0)";
				}
				break;
			}
		}
	}
</script>

<div class="z-[100]">
	<button on:click={() => toggleNavMenu()} aria-label="navigation menu">
		<svg id="hamburger" class="fill-moonstone w-8 h-8" viewBox="0 0 100 100">
			<rect
				id="hamburger-top"
				class="transition-transform duration-500 origin-center"
				width="60"
				height="10"
				fill="#475841"
				x="20"
				y="25"
				rx="7.5"
			></rect>
			<rect
				id="hamburger-mid"
				class="transition-transform duration-500 origin-center"
				width="60"
				height="10"
				fill="#475841"
				x="20"
				y="45"
				rx="7.5"
			></rect>
			<rect
				id="hamburger-bot"
				class="transition-transform duration-500 origin-center"
				width="60"
				height="10"
				fill="#475841"
				x="20"
				y="65"
				rx="7.5"
			></rect>
		</svg>
	</button>
</div>
