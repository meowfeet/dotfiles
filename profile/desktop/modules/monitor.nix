{ pkgs, ... }:

{
  systemd.user.services.cosmic-monitor-tune = {
    wantedBy = [ "cosmic-session.target" ];
    after = [ "cosmic-session.target" ];

    script = ''
      set -euo pipefail

      monitors=$(${pkgs.cosmic-randr}/bin/cosmic-randr list --kdl)

      name=$(echo "$monitors" | grep -m1 '^output ' | cut -d'"' -f2)
      monitor=$(echo "$monitors" | grep -m1 '^ *mode ')

      read -r _ width height refresh_mhz _ <<< "$monitor"
      refresh="''${refresh_mhz%???}.''${refresh_mhz: -3}"

      ${pkgs.cosmic-randr}/bin/cosmic-randr mode "$name" "$width" "$height" --refresh "$refresh"
    '';
  };
}
