{ pkgs, user, ... }:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    jq
    swaybg
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
    hotkey-overlay.skip-at-startup = true;
    gestures.hot-corners.enable = false;

    spawn-at-startup = [
      { command = [ "swaybg" "-i" "${./wallpaper.png}" "-m" "fill" ]; }
    ];

    binds = {
      "Mod+Return".action.spawn = "alacritty";
      "Mod+Q".action.close-window = {};
      "Mod+X".action.spawn-sh = "pkill fuzzel || exec fuzzel";

      "Alt+Tab".action.spawn-sh = ''niri msg action focus-workspace $((3-$(niri msg --json workspaces|jq -r '.[]|select(.is_focused).idx')))'';
      "Mod+Tab".action.spawn-sh = ''niri msg action move-column-to-workspace $((3-$(niri msg --json workspaces|jq -r '.[]|select(.is_focused).idx')))'';
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
