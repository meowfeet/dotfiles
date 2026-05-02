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
  };

  outputs =
    inputs:
    let
      inherit (inputs) nixpkgs home-manager impermanence;

      system = "x86_64-linux";
      user = import ./settings.nix;
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs user;
        };

        modules = [
          home-manager.nixosModules.default
          (nixpkgs.lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" user.name ])
          (nixpkgs.lib.mkAliasOptionModule [ "persist" ] [ "environment" "persistence" user.persistPath "users" user.name ])
          ({ config, ... }: {
            _module.args.user = user // {
              group = config.users.users.${user.name}.group;
            };
          })
          impermanence.nixosModules.impermanence
          ./core
          ./hardware-configuration.nix
          ./profile
          ./scripts
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

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
