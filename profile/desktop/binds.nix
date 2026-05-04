{ ... }:

{
  hm.programs.niri.settings.binds = {
    # added by default: written for clarity
    # "Mod+MouseLeft".action.toggle-window-floating = {};

    "Mod+X".action.maximize-column = {};
    "Mod+Alt+X".action.fullscreen-window = {};

    "Mod+Space".action.switch-preset-column-width = {};
    "Mod+MouseMiddle".action.close-window = {};

    "Mod+MouseBack".action.focus-column-left = {};
    "Mod+MouseForward".action.focus-column-right = {};
    "Mod+WheelScrollUp".action.focus-workspace-up = {};
    "Mod+WheelScrollDown".action.focus-workspace-down = {};

    "Mod+Alt+MouseBack".action.move-column-left = {};
    "Mod+Alt+MouseForward".action.move-column-right = {};
    "Mod+Alt+WheelScrollUp".action.move-column-to-workspace-up = {};
    "Mod+Alt+WheelScrollDown".action.move-column-to-workspace-down = {};

    "Mod+S".action.screenshot = {};
    "Mod+Alt+S".action.screenshot-window = {};
  };
}
