{ lib, pkgs, ... }:

let
  theme = lib.cosmic.importRON "${pkgs.cosmic-initial-setup}/share/cosmic-themes/nebula-dark.ron";
in
{
  hm.wayland.desktopManager.cosmic.appearance.theme = {
    mode = "dark";

    dark = theme // {
      bg_color = {
        __type = "optional";
        value = theme.bg_color.value // { alpha = 0.9; };
      };
    };
  };
}
