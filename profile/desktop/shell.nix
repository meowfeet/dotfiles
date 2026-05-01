{ user, ... }:

{
  systemd.tmpfiles.rules = [
    "L+ /var/lib/AccountsService/icons/${user.name} - - - - ${../portrait.png}"
    "f+ /var/lib/AccountsService/users/${user.name} 0600 root root - [User]\\nIcon=/var/lib/AccountsService/icons/${user.name}\\n"
  ];

  nixpkgs.overlays = [
    (_: prev: {
      gnome-shell = prev.gnome-shell.overrideAttrs (old: {
        mesonFlags = (old.mesonFlags or [ ]) ++ [
          "-Dextensions_app=false"
        ];

        postPatch = (old.postPatch or "") + ''
          substituteInPlace js/ui/sessionMode.js \
            --replace-fail "left: ['activities']" "left: []"
        '';
      });
    })
  ];
}
