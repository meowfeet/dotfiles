{ ... }:

{
  hm.programs.niri.settings.binds = {
    # added by default: written for clarity
    # "Mod+MouseLeft".action.toggle-window-floating = {};

    "Mod+Tab".action.toggle-overview = {};

    "Mod+B".action.spawn = "chromium";
    "Mod+E".action.spawn = "zeditor";

    "Mod+MouseMiddle".action.close-window = {};
    "Mod+Shift+MouseBack".action.maximize-column = {};
    "Mod+Shift+MouseForward".action.fullscreen-window = {};

    "Mod+WheelScrollUp".action.move-column-left = {};
    "Mod+WheelScrollDown".action.move-column-right = {};

    "Mod+MouseBack".action.move-column-to-workspace-down = {};
    "Mod+MouseForward".action.move-column-to-workspace-up = {};

    "Mod+S".action.screenshot-window = {};
    "Mod+Alt+S".action.screenshot-screen = {};
    "Mod+Shift+S".action.screenshot = {};
  };
}
