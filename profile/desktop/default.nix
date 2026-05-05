{ user, ... }:

{
  imports = [
    ./modules
  ];

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  services.displayManager.autoLogin = {
    enable = true;
    user = user.name;
  };

  services.xserver.xkb = user.keyboard;
}
