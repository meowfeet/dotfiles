{ ... }:

let
  settings = import ./settings.nix;
  impermanence = fetchTarball {
    url = "https://github.com/nix-community/impermanence/archive/master.tar.gz";
  };
in
{
  _module.args.user = settings;

  imports = [
    "${impermanence}/nixos.nix"
    ./core
    ./hardware-configuration.nix
    ./profile
    ./scripts
  ];
}
