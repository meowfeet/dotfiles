{ pkgs, config, ... }:

{
  hm.home.packages = [ pkgs.swaybg ];

  hm.programs.niri.settings.spawn-at-startup = [
    { argv = [ "swaybg" "-i" "${config.stylix.image}" "-m" "fill" ]; }
  ];
}
