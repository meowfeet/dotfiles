{ pkgs, ... }:

{
  hm.home.packages = [ pkgs.jq ];

  hm.programs.niri.settings.binds = {
    "Mod+Return".action.spawn = "foot";
    "Mod+Space".action.spawn-sh = "pkill fuzzel || fuzzel";
    "Mod+Q".action.close-window = {};

    "Mod+D".action.focus-window-up = {};
    "Mod+Z".action.focus-column-left = {};
    "Mod+X".action.focus-window-down = {};
    "Mod+C".action.focus-column-right = {};

    "Mod+Alt+D".action.move-window-up = {};
    "Mod+Alt+Z".action.move-column-left = {};
    "Mod+Alt+X".action.move-window-down = {};
    "Mod+Alt+C".action.move-column-right = {};

    "Mod+F".action.maximize-column = {};

    "Mod+Shift+S".action.screenshot = {};
    "Mod+Alt+S".action.screenshot-window = {};

    "Alt+Tab".action.spawn-sh = ''niri msg action focus-workspace $((3-$(niri msg --json workspaces|jq -r '.[]|select(.is_focused).idx')))'';
    "Mod+Tab".action.spawn-sh = ''niri msg action move-column-to-workspace $((3-$(niri msg --json workspaces|jq -r '.[]|select(.is_focused).idx')))'';
  };
}
