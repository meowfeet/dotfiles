{ user, pkgs, ... }:

{
  imports = [
    ./modules
  ];

  services.desktopManager.cosmic.enable = true;
  hm.wayland.desktopManager.cosmic.enable = true;

  services.displayManager.cosmic-greeter.enable = true;
  security.pam.services.cosmic-greeter.enableGnomeKeyring = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = user.name;
  };

  services.desktopManager.cosmic.showExcludedPkgsWarning = false;
  environment.cosmic.excludePackages = [ pkgs.cosmic-initial-setup ];
  hm.wayland.desktopManager.cosmic.panels = [ ];
}
