{ ... }:

let
  settings = import ./profile/settings.nix;
  impermanence = fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
  };
in
{
  _module.args.user = settings;

  imports = [
    "${impermanence}/nixos.nix"
    ./hardware-configuration.nix
    ./modules/audio
    ./modules/hardware
    ./modules/network
    ./profile
    ./scripts
  ];
}
