{
  description = "Declarative terminal and Neovim setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      mkHome = { username, system, homeDirectory, extraModules ? [ ] }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          modules = [
            ./nix/home
            ./nix/modules/nvim.nix
            {
              home.username = username;
              home.homeDirectory = homeDirectory;
            }
          ] ++ extraModules;
        };

      mkDarwin = { hostname, username, system, homeDirectory, extraModules ? [ ] }:
        nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit hostname username homeDirectory;
          };

          modules = [
            ./nix/darwin
            home-manager.darwinModules.home-manager
            {
              nixpkgs.hostPlatform = system;

              users.users.${username}.home = homeDirectory;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} = {
                imports = [
                  ./nix/home
                  ./nix/modules/nvim.nix
                ];

                home.username = username;
                home.homeDirectory = homeDirectory;
              };
            }
          ] ++ extraModules;
        };

      profiles = {
        "ark@macbook" = {
          username = "ark";
          system = "aarch64-darwin";
          homeDirectory = "/Users/ark";
        };

        # Example Linux profile:
        #
        # "alex@linuxbox" = {
        #   username = "alex";
        #   system = "x86_64-linux";
        #   homeDirectory = "/home/alex";
        # };
      };

      darwinProfiles = {
        macbook = {
          hostname = "macbook";
          username = "ark";
          system = "aarch64-darwin";
          homeDirectory = "/Users/ark";
        };
      };
    in
    {
      homeConfigurations =
        builtins.mapAttrs (_name: profile: mkHome profile) profiles;

      darwinConfigurations =
        builtins.mapAttrs (_name: profile: mkDarwin profile) darwinProfiles;

      homeManagerModules = {
        terminal = ./nix/home;
        nvim = ./nix/modules/nvim.nix;
      };
    };
}
