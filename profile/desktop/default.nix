{ user, pkgs, ... }:

{
  hm.imports = [ ./modules ];

  services.desktopManager.cosmic.enable = true;
  hm.wayland.desktopManager.cosmic.enable = true;

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
