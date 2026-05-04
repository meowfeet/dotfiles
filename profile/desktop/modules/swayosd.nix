{ pkgs, ... }:

{
  hm.home.packages = with pkgs; [
    playerctl
    swayosd
  ];

  hm.programs.niri.settings = {
    spawn-at-startup = [
      { argv = [ "swayosd-server" ]; }
    ];

    binds = {
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
}
