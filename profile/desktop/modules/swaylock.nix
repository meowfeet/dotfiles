{ ... }:

{
  hm.programs.swaylock.enable = true;
  security.pam.services.swaylock = { };

  hm.programs.niri.settings.binds = {
    "Mod+L".action.spawn = "swaylock";
  };
}
