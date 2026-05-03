{ pkgs, user, ... }:

{
  imports = [
    ./binds.nix
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "uwsm start hyprland.desktop";
      user = user.name;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "hyprland" "gtk" ];
  };

  hm.programs.kitty.enable = true;

  hm.programs.fuzzel = {
    enable = true;

    settings.main.default-launch-prefix = "uwsm app -- ";
  };

  hm.services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "${./wallpaper.png}";
        }
      ];
    };
  };

  hm.wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;

    settings = {
      "$mod" = "SUPER";

      monitor = ",highrr,auto,auto";

      input.accel_profile = "flat";
    };
  };
}
