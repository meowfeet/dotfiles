{ lib, pkgs, ... }:

{
  imports = [
    ./nvidia.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIXOS_OZONE_WL = "1";
  };

  hardware.bluetooth.enable = false;

  services.fstrim.enable = true;

  systemd.services.set-power-profile = rec {
    wantedBy = [ "power-profiles-daemon.service" ];
    after = wantedBy;

    script = "${lib.getExe pkgs.power-profiles-daemon} set performance";
  };
}
