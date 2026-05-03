{ pkgs, user, ... }:

{
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

      bind = [
        "$mod, Return, exec, uwsm app -- kitty"
        "$mod, Q, forcekillactive,"
      ];

      bindr = [
        "$mod, SUPER_L, exec, pkill fuzzel || uwsm app -- fuzzel"
        "$mod, Z, workspace, 1"
        "$mod, C, workspace, 2"
      ];

      bindo = [
        "$mod, Z, movetoworkspace, 1"
        "$mod, C, movetoworkspace, 2"
      ];
    };
  };
}
