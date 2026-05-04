{ pkgs, ... }:

{
  hm.home.packages = [ pkgs.waylock ];
  security.pam.services.waylock = { };

  hm.programs.niri.settings.binds = {
    "Mod+L".action.spawn = "waylock";
  };
}
