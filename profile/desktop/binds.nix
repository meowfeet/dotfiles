{ ... }:

{
  hm.programs.niri.settings.binds = {
    # added by default: written for clarity
    # "Mod+MouseLeft".action.toggle-window-floating = {};

    "Mod+Tab".action.toggle-overview = {};
    "Alt+Tab".action.switch-preset-column-width = {};
    "Mod+Escape".action.toggle-keyboard-shortcuts-inhibit = {};

    "Mod+MouseMiddle".action.close-window = {};
    "Mod+Shift+MouseBack".action.maximize-column = {};
    "Mod+Shift+MouseForward".action.fullscreen-window = {};

    "WheelScrollUp".action.focus-column-left = {};
    "WheelScrollDown".action.focus-column-right = {};
    "Mod+WheelScrollUp".action.move-column-left = {};
    "Mod+WheelScrollDown".action.move-column-right = {};

    "MouseBack".action.focus-workspace-down = {};
    "MouseForward".action.focus-workspace-up = {};
    "Mod+MouseBack".action.move-column-to-workspace-down = {};
    "Mod+MouseForward".action.move-column-to-workspace-up = {};

    "Mod+S".action.screenshot-window = {};
    "Mod+Alt+S".action.screenshot-screen = {};
    "Mod+Shift+S".action.screenshot = {};
  };
}
