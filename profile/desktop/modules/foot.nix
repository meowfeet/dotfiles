{ ... }:

{
  hm.programs.foot = {
    enable = true;

    settings.mouse-bindings = {
      scrollback-up-mouse = "BTN_WHEEL_BACK Alt+BTN_WHEEL_BACK";
      scrollback-down-mouse = "BTN_WHEEL_FORWARD Alt+BTN_WHEEL_FORWARD";
    };
  };

  hm.programs.niri.settings.binds = {
    "Mod+Backspace".action.spawn = "foot";
  };
}
