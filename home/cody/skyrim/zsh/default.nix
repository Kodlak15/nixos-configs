{
  pkgs,
  config,
  ...
}: {
  programs.zsh = {
    enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    shellAliases = {
      NIXCFG = "$HOME/nix/flakes/nixos/";
      ls = "eza -l";
      lsa = "eza -la";
      e = "fzedit";
      o = "fzopen";
      z = "zellij";
      nd = "nix develop";
      nb = "nix build";
      nr = "nix run";
      alacritty = "nvidia-offload alacritty";
      screenshot = "$HOME/nix/flakes/nixos/scripts/screenshot.sh";
      cat = "bat";
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.1";
          sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
        };
      }
    ];
    initExtra = ''
      export TERM=xterm-256color
      export ZELLIJ_AUTO_START=false

      # Edit PATH
      export PATH="$PATH:$HOME/nix/flakes/nixos/scripts/"
      export PATH="$PATH:$HOME/bin/"

      # Set default editor (TODO: this should be done elsewhere, needed for laptop)
      export EDITOR="nvim"

      # Git status info
      autoload -Uz vcs_info
      precmd() { vcs_info }
      zstyle ':vcs_info:git:*' formats " %F{#e0af68} %b%f"
      setopt prompt_subst
      source $HOME/.nix-profile/share/git/contrib/completion/git-prompt.sh
      setopt PROMPT_SUBST

      # Fuzzy find and open a directory
      fzopen() {
      	directory="$(find * -type d | ${pkgs.fzf}/bin/fzf)"
      	if [[ -n "$directory" ]]; then
      	  cd "$directory"
        fi
      }

      # Fuzzy find and edit a file with default text editor
      fzedit() {
      	file="$(${pkgs.fzf}/bin/fzf)"
      	if [[ -n "$file" ]]; then
      		"$EDITOR" "$file"
      	fi
      }

      # Set pywal generated terminal colors
      (cat ~/.cache/wal/sequences &)

      # Add pywal support for tty
      source ~/.cache/wal/colors-tty.sh

      # Source the colors file
      source $HOME/.cache/wal/colors-zsh.zsh

      # Prompt
      PROMPT=' %~ % $(__git_ps1 "(%s)")󰄾 '
    '';
    loginExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        case "$(hostnamectl chassis | xargs)" in
          "desktop") exec Hyprland &> /dev/null ;;
          "laptop") exec nvidia-offload Hyprland &> /dev/null ;;
        esac
      fi
    '';
    profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        case "$(hostnamectl chassis | xargs)" in
          "desktop") exec Hyprland &> /dev/null ;;
          "laptop") exec nvidia-offload Hyprland &> /dev/null ;;
        esac
      fi
    '';
  };
}
