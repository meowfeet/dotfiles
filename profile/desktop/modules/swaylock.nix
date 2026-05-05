{ ... }:

{
  hm.programs.swaylock = {
    enable = true;

    settings = {
      no-unlock-indicator = true;
    };
  };

  security.pam.services.swaylock = { };

  hm.programs.niri.settings.binds = {
    "Mod+L".action.spawn = "swaylock";
  };
}
