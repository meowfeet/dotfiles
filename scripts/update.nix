{
  config,
  pkgs,
  user,
  ...
}:

let
  perms = "${user.persistPath}/.permissions";
in
{
  system.tools.nixos-rebuild.enable = false;

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "${user.scriptPrefix}-update" ''
      set -euo pipefail

      if [ "$EUID" -ne 0 ]; then
        printf '%s\n' "sudo required" >&2
        exit 1
      fi

      if [ "$#" -gt 1 ]; then
        printf '%s\n' "too many flags" >&2
        exit 1
      fi

      local=false
      reset=false

      case "''${1:-}" in
        "")
          ;;
        --local)
          local=true
          ;;
        --reset-generations)
          reset=true
          ;;
        *)
          printf '%s\n' "unknown flag" >&2
          exit 1
          ;;
      esac

      if [ "$local" = false ]; then
        ${pkgs.git}/bin/git -C /etc/nixos fetch origin
        ${pkgs.git}/bin/git -C /etc/nixos reset --hard origin/master
        ${pkgs.git}/bin/git -C /etc/nixos clean -fdx
      fi

      for snapshot in ${perms}/nix.acl ${perms}/persist.acl; do
        [ ! -e "$snapshot" ] || ${pkgs.acl}/bin/setfacl --restore="$snapshot" 2>/dev/null || true
      done

      nix-channel --add https://channels.nixos.org/nixos-unstable nixos
      nix-channel --update

      if [ "$reset" = true ]; then
        rm -f /nix/var/nix/profiles/system-*-link
      fi

      ${config.system.build.nixos-rebuild}/bin/nixos-rebuild boot

      mkdir -p ${perms}
      touch ${perms}/save

      reboot
    '')
  ];

  systemd.services."${user.scriptPrefix}-cleanup" = {
    wantedBy = [ "graphical.target" ];
    after = [ "graphical.target" ];

    script = ''
      set -euo pipefail

      ${config.nix.package}/bin/nix-collect-garbage -d
      /run/current-system/bin/switch-to-configuration boot

      if [ -e ${perms}/save ]; then
        chown root:root ${perms}
        chmod 700 ${perms}

        ${pkgs.acl}/bin/getfacl -R -p /nix > ${perms}/nix.acl.tmp
        mv -f ${perms}/nix.acl.tmp ${perms}/nix.acl
        chown root:root ${perms}/nix.acl
        chmod 600 ${perms}/nix.acl

        ${pkgs.acl}/bin/getfacl -R -p ${user.persistPath} > ${perms}/persist.acl.tmp
        mv -f ${perms}/persist.acl.tmp ${perms}/persist.acl
        chown root:root ${perms}/persist.acl
        chmod 600 ${perms}/persist.acl

        rm -f ${perms}/save
      fi
    '';
  };
}
