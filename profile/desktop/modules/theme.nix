{ lib, pkgs, ... }:

let
  theme = lib.cosmic.importRON "${pkgs.cosmic-initial-setup}/share/cosmic-themes/nebula-dark.ron";

  opacity = 0.9;
in
{
  hm.wayland.desktopManager.cosmic.appearance.theme = {
    mode = "dark";

    dark = theme // {
      bg_color = {
        __type = "optional";
        value = theme.bg_color.value // { alpha = opacity; };
      };
    };
  };

  hm.wayland.desktopManager.cosmic.configFile."com.system76.CosmicTerm" = {
    version = 1;
    entries.opacity = builtins.floor (opacity * 100);
  };
}
