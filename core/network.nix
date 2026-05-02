{ ... }:

{
  networking.firewall.enable = true;
  networking.hostName = "nixos";

  networking.networkmanager.enable = false;
  networking.useDHCP = true;
}
