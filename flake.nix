{
  description = "OpenClaw local - Generic configuration for Stephen";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-openclaw.url = "github:openclaw/nix-openclaw";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-openclaw,
    }:
    let
      # REPLACE: aarch64-darwin (Apple Silicon) or x86_64-linux
      system = "x86_64-linux";  # or "aarch64-darwin" for macOS
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-openclaw.overlays.default ];
      };
      # REPLACE: /home/stephen on Linux or /Users/stephen on macOS
      homeDir = "/home/stephen";
    in
    {
      # Home configuration for Stephen
      homeConfigurations."stephen" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          nix-openclaw.homeManagerModules.openclaw
          {
            home.username = "stephen";
            home.homeDirectory = homeDir;
            home.stateVersion = "24.11";
            programs.home-manager.enable = true;

            # OpenClaw configuration
            programs.openclaw = {
              workspace.bootstrapFiles = {
                agents = ./workspace/AGENTS.md;
                soul = ./workspace/SOUL.md;
                tools = ./workspace/TOOLS.md;
                identity = ./workspace/IDENTITY.md;
                user = ./workspace/USER.md;
              };

              # Schema-typed OpenClaw config (from upstream)
              config = {
                gateway = {
                  mode = "local";
                  auth = {
                    # REPLACE: long random token for gateway auth
                    token = "<gateway-token>";
                  };
                };

                # Example channel configuration (uncomment as needed)
                # channels.telegram = {
                #   tokenFile = "<path-to-bot-token-file>";
                #   allowFrom = [ "<telegram-user-id>" ];
                #   groups = {
                #     "*" = {
                #       requireMention = true;
                #     };
                #   };
                # };
              };

              enable = true;
            };

            # Additional Home Manager configuration
            programs.zsh = {
              enable = true;
              autosuggestion.enable = true;
            };

            programs.fzf.enable = true;
            programs.bat.enable = true;

            # Optional: Set default shell
            shell = zsh;

            # Optional: Additional packages
            packages = with pkgs; [
              git
              neovim
              tree
              ripgrep
              fd
              zoxide
            ];

            # Optional: Dotfiles
            home.file.".gitconfig".source = ./dotfiles/gitconfig;
            home.file.".config/nvim/init.vim".source = ./dotfiles/nvim/init.vim;
            home.file.".config/nvim/init.lua".source = ./dotfiles/nvim/init.lua;
          }
        ];
      };

      # Default application (OpenClaw gateway)
      apps.openclaw = home-manager.lib.mkApp {
        drv = (nix-openclaw.packages.${system}.openclaw or null);
      };
    };
}
