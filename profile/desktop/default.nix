{ pkgs, user, ... }:

{
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    jq
    playerctl
    swaybg
    swayosd
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
      { command = [ "swayosd-server" ]; }
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

      "XF86AudioRaiseVolume".action.spawn = [ "swayosd-client" "--output-volume" "+10" "--max-volume" "100" ];
      "XF86AudioLowerVolume".action.spawn = [ "swayosd-client" "--output-volume" "-10" ];
      "XF86AudioMute".action.spawn = [ "swayosd-client" "--output-volume" "mute-toggle" ];
      "XF86AudioMicMute".action.spawn = [ "swayosd-client" "--input-volume" "mute-toggle" ];

      "XF86AudioPlay".action.spawn = [ "swayosd-client" "--playerctl" "play-pause" ];
      "XF86AudioStop".action.spawn = [ "swayosd-client" "--playerctl" "stop" ];
      "XF86AudioPrev".action.spawn = [ "swayosd-client" "--playerctl" "prev" ];
      "XF86AudioNext".action.spawn = [ "swayosd-client" "--playerctl" "next" ];
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config.common.default = "*";
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
