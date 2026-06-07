# Generic home.nix for Stephen
# This file configures Home Manager standalone or as part of a larger NixOS config
#
# Usage with Home Manager standalone:
#   home-manager switch -D home.nix
#
# Usage with NixOS (include in nixos/configuration.nix):
#   {
#     imports = [ ./home.nix ];
#   }

{ config, pkgs, ... }:

{
  # User configuration
  home = {
    username = "stephen";
    homeDirectory = "/home/stephen";
    stateVersion = "24.11";
  };

  # Shell configuration
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntax-highlighting.enable = true;
  };

  # Optional: bash (uncomment if using bash)
  # programs.bash = {
  #   enable = true;
  #   bashrc = ''
  #     source ${config.xdg.configHome}/zsh/zshrc
  #   '';
  # };

  # Fuzzy finder
  programs.fzf.enable = true;

  # Syntax highlighting for plain files
  programs.bat.enable = true;

  # Directory preview tool
  programs.git = {
    enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      alias = {
        co = "checkout";
        st = "status";
        br = "branch";
        lg = "log --graph --pretty=fuller -10 --stat";
        ci = "commit -v -m";
      };
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      merge = {
        conflictstyle = "zdiff";
      };
      init = {
        terminal = true;
      };
      push = {
        default = true;
      };
      remote = {
        origin.fetchAndPush = true;
      };
    };
  };

  # File manager
  programs.exa.enable = true;
  programs.fad.enable = true;

  # File preview
  programs.duf = {
    enable = true;
  };

  # Starship prompt
  programs.starship.enable = true;
  programs.starship.settings = {
    add-newline = false;
    prompt = {
      character = "💀 ";
    };
  };

  # OpenClaw workspace bootstrap files
  workspace = {
    bootstrapFiles = {
      agents = ./AGENTS.md;
      soul = ./SOUL.md;
      tools = ./TOOLS.md;
      identity = ./IDENTITY.md;
      user = ./USER.md;
    };
  };

  # OpenClaw configuration
  programs.openclaw = {
    enable = true;

    # Workspace bootstrap files
    workspace.bootstrapFiles = {
      agents = ./AGENTS.md;
      soul = ./SOUL.md;
      tools = ./TOOLS.md;
      identity = ./IDENTITY.md;
      user = ./USER.md;
    };

    # Gateway configuration
    config = {
      gateway = {
        mode = "local";
        auth = {
          # Replace with your gateway token
          token = "<your-gateway-token>";
        };
      };

      # Channel configurations (uncomment as needed)
      #
      # Telegram channel
      # channels.telegram = {
      #   tokenFile = ~/.secrets/telegram-bot-token;
      #   allowFrom = [ "123456789" ];  # Your Telegram user ID
      #   groups = {
      #     "*" = {
      #       requireMention = true;
      #     };
      #   };
      # };

      # Slack channel
      # channels.slack = {
      #   token = "${config.environmentVariables.SLACK_BOT_TOKEN}";
      #   team = "<your-team-id>";
      # };

      # Discord channel
      # channels.discord = {
      #   token = "${config.environmentVariables.DISCORD_BOT_TOKEN}";
      #   enable = true;
      # };

      # Google Chat channel
      # channels.googlechat = {
      #   accountFile = "~/.secrets/google-chat-account.json";
      #   scopes = [ "https://www.googleapis.com/auth/calendar" ];
      # };
    };

    # Environment variables for secrets
    environment = {
      # Load secrets from files
      # TELEGRAM_BOT_TOKEN = "/run/agenix/telegram-bot-token";
      # SLACK_BOT_TOKEN = "/run/agenix/slack-bot-token";
      # DISCORD_BOT_TOKEN = "/run/agenix/discord-bot-token";
    };
  };

  # Optional: Additional packages
  packages = with pkgs; [
    # Productivity
    git
    neovim
    ripgrep
    fd
    zoxide
    fzf
    bat
    exa
    starship
    tree
    yq
    jq
    # Optional: Terminal multiplexer
    # tmux
    # screen
    # Optional: Terminal emulator (if using GUI)
    # kitty
    # alacritty
    # Optional: Text editors
    # vim
    # nano
    # Optional: Image viewers
    # imagemagick
    # File manager
    # rox-filer
    # Files (GNOME)
    # Thunar (KDE)
  ];

  # Optional: Home Manager activation
  home-manager = {
    useGlobalPkgs = true;
    useGlobalTiles = true;
    backend = "home-manager";
  };
}
