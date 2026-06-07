# Generic configuration.nix for Stephen
# This file is meant to be included in a user's home.nix or used standalone
# with home-manager

# Example standalone configuration.nix for use with:
# - Home Manager standalone
# - NixOS configuration
# - Home Manager within NixOS

{ config, pkgs, ... }:

{
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

  # Optional: Additional packages for OpenClaw
  environment.variables.OPENCLAW_NIX_MODE = "1";

  # Optional: Additional user packages
  home.packages = with pkgs; [
    git
    neovim
    ripgrep
    fd
    zoxide
    fzf
    bat
    exa
    starship
  ];
}
