{ pkgs, user, ... }:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    jq
    playerctl
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
      { command = [ "waybar" ]; }
    ];

    window-rules = [
      { open-floating = false; }
    ];

    binds = {
      "Mod+Return".action.spawn = "alacritty";
      "Mod+Space".action.spawn-sh = "pkill fuzzel || exec fuzzel";
      "Mod+Q".action.close-window = {};

      "Mod+D".action.focus-window-up = {};
      "Mod+Z".action.focus-column-left = {};
      "Mod+X".action.focus-window-down = {};
      "Mod+C".action.focus-column-right = {};

      "Mod+Alt+D".action.move-window-up = {};
      "Mod+Alt+Z".action.move-column-left = {};
      "Mod+Alt+X".action.move-window-down = {};
      "Mod+Alt+C".action.move-column-right = {};

      "Mod+F".action.maximize-column = {};

      "Mod+Shift+S".action.screenshot = {};
      "Mod+Alt+S".action.screenshot-window = {};

      "Alt+Tab".action.spawn-sh = ''niri msg action focus-workspace $((3-$(niri msg --json workspaces|jq -r '.[]|select(.is_focused).idx')))'';
      "Mod+Tab".action.spawn-sh = ''niri msg action move-column-to-workspace $((3-$(niri msg --json workspaces|jq -r '.[]|select(.is_focused).idx')))'';

      "XF86AudioRaiseVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
      "XF86AudioLowerVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
      "XF86AudioMute".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      "XF86AudioMicMute".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

      "XF86AudioPlay".action.spawn-sh = "playerctl play-pause";
      "XF86AudioStop".action.spawn-sh = "playerctl stop";
      "XF86AudioPrev".action.spawn-sh = "playerctl previous";
      "XF86AudioNext".action.spawn-sh = "playerctl next";
    };
  };

  hm.programs.waybar = {
    enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";

      modules-center = [ "clock" ];
      modules-right = [ "wireplumber" ];

      clock.format = "{:%H:%M}";

      wireplumber = {
        format = "{volume}%";
        format-muted = "muted";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        scroll-step = 10;
      };
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
