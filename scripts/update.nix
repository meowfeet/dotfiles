{
  config,
  lib,
  pkgs,
  user,
  ...
}:

let
  file = lib.removeSuffix ".nix" (builtins.baseNameOf __curPos.file);
  script = "${user.scriptPrefix}-${file}";
  service = "${script}-cleanup";

  perms = "${user.persistPath}/.permissions";
in
{
  system.tools.nixos-rebuild.enable = false;

  environment.systemPackages = [
    (pkgs.writeShellScriptBin script ''
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
      nocache=false
      cleanup=false

      case "''${1:-}" in
        "")
          ;;
        --local)
          local=true
          ;;
        --no-cache)
          nocache=true
          ;;
        --unsafe-cleanup)
          cleanup=true
          ;;
        *)
          printf '%s\n' "unknown flag" >&2
          exit 1
          ;;
      esac

      if [ "$local" = false ]; then
        ${pkgs.git}/bin/git -C /etc/nixos fetch origin
        ${pkgs.git}/bin/git -C /etc/nixos reset --hard origin/master
        ${pkgs.git}/bin/git -C /etc/nixos clean -fdxq
      fi

      for snapshot in ${perms}/nix.acl ${perms}/persist.acl; do
        [ ! -e "$snapshot" ] || ${pkgs.acl}/bin/setfacl --restore="$snapshot" 2>/dev/null || true
      done

      rebuild_args=()
      if [ "$nocache" = true ]; then
        rebuild_args+=(--option substitute false)
      fi

      rm -f /etc/nixos/flake.lock
      ${config.system.build.nixos-rebuild}/bin/nixos-rebuild "''${rebuild_args[@]}" boot

      ${config.nix.package}/bin/nix-collect-garbage --delete-older-than 7d

      mkdir -p ${perms}
      touch ${perms}/save
      if [ "$cleanup" = true ]; then
        touch ${perms}/unsafe-cleanup
      fi

      reboot
    '')
  ];

  systemd.services.${service} = {
    wantedBy = [ "graphical.target" ];
    after = [ "graphical.target" ];

    script = ''
      set -euo pipefail

      if [ -e ${perms}/unsafe-cleanup ]; then
        rm -f /nix/var/nix/profiles/system-*-link
        ${config.nix.package}/bin/nix-collect-garbage -d
        rm -f ${perms}/unsafe-cleanup

        reboot
        exit 0
      fi

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
