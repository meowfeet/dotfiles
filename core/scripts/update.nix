{
  config,
  lib,
  pkgs,
  user,
  ...
}:

let
  prefix = "nix";
  file = lib.removeSuffix ".nix" (baseNameOf __curPos.file);

  script = "${prefix}-${file}";
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
        ${lib.getExe pkgs.git} -C /etc/nixos fetch origin
        ${lib.getExe pkgs.git} -C /etc/nixos reset --hard origin/master
        ${lib.getExe pkgs.git} -C /etc/nixos clean -fdxq
        ${lib.getExe pkgs.git} -C /etc/nixos gc --prune=now --quiet
      fi

      for snapshot in ${perms}/nix.acl ${perms}/persist.acl; do
        [ ! -e "$snapshot" ] || ${lib.getExe' pkgs.acl "setfacl"} --restore="$snapshot" 2>/dev/null || true
      done

      rebuild_args=()
      if [ "$nocache" = true ]; then
        rebuild_args+=(--option substitute false)
      fi

      rm -f /etc/nixos/flake.lock
      ${lib.getExe' config.system.build.nixos-rebuild "nixos-rebuild"} "''${rebuild_args[@]}" boot

      ${lib.getExe' config.nix.package "nix-collect-garbage"} --delete-older-than 7d

      mkdir -p ${perms}
      touch ${perms}/save
      if [ "$cleanup" = true ]; then
        touch ${perms}/unsafe-cleanup
      fi

      reboot
    '')
  ];

  systemd.services.${service} = rec {
    wantedBy = [ "graphical.target" ];
    after = wantedBy;

    script = ''
      set -euo pipefail

      if [ -e ${perms}/unsafe-cleanup ]; then
        rm -f /nix/var/nix/profiles/system-*-link
        ${lib.getExe' config.nix.package "nix-collect-garbage"} -d
        rm -f ${perms}/unsafe-cleanup

        reboot
        exit 0
      fi

      /run/current-system/bin/switch-to-configuration boot

      if [ -e ${perms}/save ]; then
        chown root:root ${perms}
        chmod 700 ${perms}

        ${lib.getExe' pkgs.acl "getfacl"} -R -p /nix > ${perms}/nix.acl.tmp
        mv -f ${perms}/nix.acl.tmp ${perms}/nix.acl
        chown root:root ${perms}/nix.acl
        chmod 600 ${perms}/nix.acl

        ${lib.getExe' pkgs.acl "getfacl"} -R -p ${user.persistPath} > ${perms}/persist.acl.tmp
        mv -f ${perms}/persist.acl.tmp ${perms}/persist.acl
        chown root:root ${perms}/persist.acl
        chmod 600 ${perms}/persist.acl

        rm -f ${perms}/save
      fi
    '';
  };
}
