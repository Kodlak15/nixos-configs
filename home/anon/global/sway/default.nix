{pkgs, ...}: {
	home.packages = with pkgs; [alacritty];

	wayland.windowManager.sway = {
		enable = false;
		config = rec {
			modifier = "Mod4";
			terminal = "alacritty";
		};
	};
}
