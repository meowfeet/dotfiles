{ user, ... }:

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

  hm.programs.kitty.enable = true;

  hm.wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;

    settings = {
      "$mod" = "SUPER";

      monitor = ",highrr,auto,auto";

      bind = [
        "$mod, Return, exec, uwsm app -- kitty"
        "$mod, Q, killactive,"

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
