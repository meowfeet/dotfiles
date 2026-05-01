{ user, ... }:

{
  imports = [
    ./dconf.nix
    ./packages.nix
    ./shell.nix
  ];

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.xserver.xkb = user.keyboard;

  environment.persistence.${user.persistPath}.users.${user.name} = {
    files = [
      ".config/monitors.xml"
    ];
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = user.name;
  };
}
