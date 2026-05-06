{ lib, pkgs, ... }:

{
  systemd.user.services.cosmic-monitor-tune = rec {
    wantedBy = [ "cosmic-session.target" ];
    after = wantedBy;

    script = ''
      set -euo pipefail

      monitors=$(${lib.getExe pkgs.cosmic-randr} list --kdl)

      name=$(echo "$monitors" | grep -m1 '^output ' | cut -d'"' -f2)
      monitor=$(echo "$monitors" | grep -m1 '^ *mode ')

      read -r _ width height refresh_mhz _ <<< "$monitor"
      refresh="''${refresh_mhz%???}.''${refresh_mhz: -3}"

      ${lib.getExe pkgs.cosmic-randr} mode "$name" "$width" "$height" --refresh "$refresh"
    '';
  };
}
