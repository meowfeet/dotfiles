{ lib, pkgs, ... }:

{
  hm.wayland.desktopManager.cosmic.appearance.theme = {
    mode = "dark";
    dark = lib.cosmic.importRON "${pkgs.cosmic-initial-setup}/share/cosmic-themes/nebula-dark.ron";
  };
}
