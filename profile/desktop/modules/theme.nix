{ cosmicLib, inputs, ... }:

{
  wayland.desktopManager.cosmic.appearance.theme = {
    mode = "dark";
    dark = cosmicLib.cosmic.importRON "${inputs.cosmic-initial-setup}/res/themes/nebula-dark.ron";
  };
}
