{ pkgs, ... }:

{
  imports = [
    ./nvidia.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  nixpkgs.config.allowUnfree = true;

  documentation.nixos.enable = false;

  hardware.bluetooth.enable = false;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.fstrim.enable = true;
}
