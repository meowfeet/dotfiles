{ user, config, ... }:

{
  imports = [
    ./binds.nix
    ./modules
  ];

  programs.niri.enable = true;

  hm.programs.niri.settings = {
    prefer-no-csd = true;
    hotkey-overlay.skip-at-startup = true;
    gestures.hot-corners.enable = false;

    input.keyboard.xkb = user.keyboard;
    input.mouse.accel-profile = "flat";

    outputs.${user.monitor.name}.mode = {
      inherit (user.monitor) width height refresh;
    };

    layout.focus-ring = {
      active.color = config.lib.stylix.colors.withHashtag.base0D;
      inactive.color = config.lib.stylix.colors.withHashtag.base03;
    };

    window-rules = [
      {
        open-floating = false;
        open-fullscreen = false;
      }
    ];
  };
}
