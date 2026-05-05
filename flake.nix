{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cosmic-manager = {
      url = "github:heitoraugustoln/cosmic-manager";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cosmic-initial-setup = {
      url = "github:pop-os/cosmic-initial-setup";
      flake = false;
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs) nixpkgs home-manager impermanence cosmic-manager;

      system = "x86_64-linux";
      user = import ./settings.nix;
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
        };

        modules = [
          home-manager.nixosModules.default
          impermanence.nixosModules.impermanence

          (nixpkgs.lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" user.name ])
          (nixpkgs.lib.mkAliasOptionModule [ "persist" ] [ "environment" "persistence" user.persistPath "users" user.name ])

          ({ config, ... }: {
            _module.args.user = user // {
              group = config.users.users.${user.name}.group;
            };
          })

          ./core
          ./hardware-configuration.nix
          ./profile
          ./scripts

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              sharedModules = [ cosmic-manager.homeManagerModules.default ];

              extraSpecialArgs = {
                inherit inputs user;
              };

              users.${user.name} =
                { osConfig, ... }:
                {
                  home.stateVersion = osConfig.system.stateVersion;
                };
            };
          }
        ];
      };
    };
}
