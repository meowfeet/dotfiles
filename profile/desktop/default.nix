{ user, pkgs, ... }:

{
  imports = [
    ./modules
  ];

  services.desktopManager.cosmic.enable = true;
  hm.wayland.desktopManager.cosmic = {
    enable = true;

    configFile."com.system76.CosmicTerm" = {
      version = 1;
      entries.opacity = 90;
    };
  };

  services.displayManager.cosmic-greeter.enable = true;
  security.pam.services.cosmic-greeter.enableGnomeKeyring = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = user.name;
  };

  services.xserver.xkb = user.keyboard;

  services.desktopManager.cosmic.showExcludedPkgsWarning = false;
  environment.cosmic.excludePackages = [ pkgs.cosmic-initial-setup ];
}
