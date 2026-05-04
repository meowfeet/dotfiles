{ pkgs, user, ... }:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
  ];

  services.greetd = {
    enable = true;

    settings.default_session = {
      command = "niri-session";
      user = user.name;
    };
  };

  hm.programs.niri.settings = {
    prefer-no-csd = true;
    input.keyboard.xkb = user.keyboard;
    layout.gaps = 4;

    binds = {
      "Mod+Return".action.spawn = "alacritty";
      "Mod+Q".action.close-window = {};
      "Mod+X".action.spawn-sh = "pkill fuzzel || exec fuzzel";

      "Mod+Z".action.focus-workspace = 1;
      "Mod+C".action.focus-workspace = 2;
      "Mod+A".action.move-column-to-workspace = 1;
      "Mod+D".action.move-column-to-workspace = 2;
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
