{ ... }:
{
  programs.zsh = {
    enable = true;

    history = {
      ignoreSpace = true;
      ignoreDups = true;
    };

    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      if [[ -r \"''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh\" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    sessionVariables = {
      ENHANCD_FILTER = "fzf";
      ENHANCD_COMPLETION_BEHAVIOR = "list";
    };

    initExtra = ''
      # Source other resource
      [ -x "$(command -v direnv)" ] && eval "$(direnv hook zsh)"
      [ -f $HOME/.localrc ] && source $HOME/.localrc # Local configuration
    '';

    zplug = {
      enable = true;
      plugins = [
        {
          name = "zplug/zplug";
          tags = [ "hook-build:'zplug --self-managed'" ];
        }
        {
          name = "romkatv/powerlevel10k";
          tags = [ "as:theme" "depth:1" ];
        }
        {
          name = "lib/completion";
          tags = [ "from:oh-my-zsh" "depth:1" ];
        }
        {
          name = "lib/history";
          tags = [ "from:oh-my-zsh" "depth:1" ];
        }
        {
          name = "lib/key-bindings";
          tags = [ "from:oh-my-zsh" "depth:1" ];
        }
        {
          name = "junegunn/fzf";
          tags = [ "use:\"shell/*.zsh\"" "depth:1" "defer:3" ];
        }
        {
          name = "zsh-users/zsh-autosuggestions";
          tags = [ "depth:1" ];
        }
        {
          name = "zsh-users/zsh-completions";
          tags = [ "depth:1" ];
        }
        {
          name = "b4b4r07/enhancd";
          tags = [ "use:init.sh" "depth:1" ];
        }
        {
          name = "zdharma-continuum/fast-syntax-highlighting";
          tags = [ "depth:1" "defer:2" ];
        }
        {
          name = "hlissner/zsh-autopair";
          tags = [ "depth:1" "defer:2" ];
        }
        {
          name = "plugins/kubectl";
          tags = [ "from:oh-my-zsh" "as:plugin" "depth:1" "defer:2" ];
        }
        {
          name = "plugins/docker";
          tags = [ "from:oh-my-zsh" "as:plugin" "depth:1" "defer:2" ];
        }
        {
          name = "plugins/vscode";
          tags = [ "from:oh-my-zsh" "as:plugin" "depth:1" "defer:2" ];
        }
        {
          name = "\$HOME/.config/zsh";
          tags = [ "from:local" ];
        }
      ];
    };
  };

  xdg.configFile."zsh" = {
    recursive = true;
    source = ./config;
  };

  home.file.".local/bin" = {
    recursive = true;
    source = ./bin;
  };

}
