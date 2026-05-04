{ pkgs, ... }:

{
  hm.home.packages = [ pkgs.jq ];

  hm.programs.niri.settings.binds = {
    "Mod+Return".action.spawn-sh = "pkill fuzzel || fuzzel";
    "Mod+Backspace".action.spawn = "foot";
    # "Mod+L".action.spawn-sh = "loginctl lock-session";

    "Mod+Escape".action.toggle-overview = {};
    "Mod+X".action.switch-preset-column-width = {};

    "Mod+MouseMiddle".action.maximize-column = {};
    "Mod+Shift+MouseMiddle".action.fullscreen-window = {};
    "Mod+Shift+Alt+MouseMiddle".action.close-window = {};

    "Mod+MouseBack".action.focus-window-up = {};
    "Mod+WheelScrollUp".action.focus-column-left = {};
    "Mod+MouseForward".action.focus-window-down = {};
    "Mod+WheelScrollDown".action.focus-column-right = {};

    "Mod+Shift+MouseBack".action.move-window-up = {};
    "Mod+Shift+WheelScrollUp".action.move-column-left = {};
    "Mod+Shift+MouseForward".action.move-window-down = {};
    "Mod+Shift+WheelScrollDown".action.move-column-right = {};

    "Mod+Alt+MouseBack".action.consume-or-expel-window-left = {};
    "Mod+Alt+MouseForward".action.consume-or-expel-window-right = {};

    "Mod+S".action.screenshot = {};
    "Mod+Shift+S".action.screenshot-window = {};

    "Alt+Tab".action.spawn-sh = ''niri msg action focus-workspace $((3-$(niri msg --json workspaces|jq -r '.[]|select(.is_focused).idx')))'';
    "Mod+Tab".action.spawn-sh = ''niri msg action move-column-to-workspace $((3-$(niri msg --json workspaces|jq -r '.[]|select(.is_focused).idx')))'';
  };
}
