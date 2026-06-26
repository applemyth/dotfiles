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
      lib = nixpkgs.lib;

      homeDirectoryFor = system: username:
        if lib.hasSuffix "-darwin" system
        then "/Users/${username}"
        else "/home/${username}";

      normalizeProfile = profile:
        profile // {
          homeDirectory =
            profile.homeDirectory or (homeDirectoryFor profile.system profile.username);
        };

      mkHome = profileArg:
        let
          profile = normalizeProfile profileArg;
        in
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit (profile) system;
            config.allowUnfree = true;
          };

          modules = [
            ./nix/home
            ./nix/modules/nvim.nix
            {
              home.username = profile.username;
              home.homeDirectory = profile.homeDirectory;
            }
          ] ++ (profile.extraModules or [ ]);
        };

      mkDarwin = hostname: profileArg:
        let
          profile = normalizeProfile profileArg;
        in
        nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit hostname;
            inherit (profile) username homeDirectory;
          };

          modules = [
            ./nix/darwin
            home-manager.darwinModules.home-manager
            {
              nixpkgs.hostPlatform = profile.system;

              users.users.${profile.username}.home = profile.homeDirectory;

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${profile.username} = {
                imports = [
                  ./nix/home
                  ./nix/modules/nvim.nix
                ];

                home.username = profile.username;
                home.homeDirectory = profile.homeDirectory;
              };
            }
          ] ++ (profile.extraModules or [ ]);
        };

      hosts = {
        macbook = {
          username = "hershybar";
          system = "aarch64-darwin";
        };

        archie = {
          username = "hershiebar";
          system = "x86_64-linux";
        };
      };

      homeProfiles = lib.mapAttrs'
        (hostname: profile:
          lib.nameValuePair "${profile.username}@${hostname}" profile)
        hosts;

      darwinProfiles =
        lib.filterAttrs (_hostname: profile: lib.hasSuffix "-darwin" profile.system) hosts;
    in
    {
      homeConfigurations =
        builtins.mapAttrs (_name: profile: mkHome profile) homeProfiles;

      darwinConfigurations =
        builtins.mapAttrs (hostname: profile: mkDarwin hostname profile) darwinProfiles;

      homeManagerModules = {
        terminal = ./nix/home;
        nvim = ./nix/modules/nvim.nix;
      };
    };
}
