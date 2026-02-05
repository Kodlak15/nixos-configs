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
    oh-my-zsh = {
      enable = true;
      plugins = ["git"];
      theme = "lambda";
    };
    enableCompletion = true;
    completionInit = ''
      #compdef opencode
      ###-begin-opencode-completions-###
      #
      # yargs command completion script
      #
      # Installation: opencode completion >> ~/.zshrc
      #    or opencode completion >> ~/.zprofile on OSX.
      #
      _opencode_yargs_completions()
      {
        local reply
        local si=$IFS
        IFS=$'
      ' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" opencode --get-yargs-completions "$${words[@]}"))
        IFS=$si
        if [[ $${#reply} -gt 0 ]]; then
          _describe 'values' reply
        else
          _default
        fi
      }
      if [[ "'$${zsh_eval_context[-1]}" == "loadautofunc" ]]; then
        _opencode_yargs_completions "$@"
      else
        compdef _opencode_yargs_completions opencode
      fi
      ###-end-opencode-completions-###
    '';
    autosuggestion.enable = true;
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

    initContent = ''
      export TERM=xterm-256color
      export ZELLIJ_AUTO_START=false

      # Make API keys available in environment
      # export ANTHROPIC_API_KEY="$(cat $XDG_RUNTIME_DIR/anthropic_api_key)"

      # Fuzzy find and open a directory
      fzopen() {
      	directory="$(find * -type d | ${pkgs.fzf}/bin/fzf)"
      	if [[ -n "$directory" ]]; then
      	  cd "$directory"
        fi
      }

      # Fuzzy find and edit a file with neovim
      fzedit() {
      	file="$(fzf)"
      	if [[ -n "$file" ]]; then
      		nvim "$file"
      	fi
      }
    '';

    loginExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        case "$(hostnamectl chassis | xargs)" in
          # "desktop") exec Hyprland &> /dev/null ;;
          # "laptop") exec nvidia-offload Hyprland &> /dev/null ;;
          "desktop") exec start-hyprland &> /dev/null ;;
          "laptop") exec nvidia-offload start-hyprland &> /dev/null ;;
        esac
      fi
    '';

    profileExtra = ''
      if [ "$(tty)" = "/dev/tty1" ]; then
        case "$(hostnamectl chassis | xargs)" in
          # "desktop") exec Hyprland &> /dev/null ;;
          # "laptop") exec nvidia-offload Hyprland &> /dev/null ;;
          "desktop") exec start-hyprland &> /dev/null ;;
          "laptop") exec nvidia-offload start-hyprland &> /dev/null ;;
        esac
      fi
    '';
  };
}
