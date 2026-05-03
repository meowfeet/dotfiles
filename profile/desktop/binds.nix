{ ... }:

{
  hm.wayland.windowManager.hyprland.settings = {
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
}
