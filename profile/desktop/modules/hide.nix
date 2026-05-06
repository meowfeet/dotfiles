{ ... }:

{
  nixpkgs.overlays = [
    (_: prev: {
      pop-launcher = prev.pop-launcher.overrideAttrs (old: {
        postInstall = (old.postInstall or "") + ''
          rm -rf $out/share/pop-launcher/plugins/{pulse,scripts}
        '';
      });
    })
  ];

  environment.extraSetup = ''
    if [[ "$out" == *-system-path ]]; then
      shopt -s nullglob
      for link in $out/share/applications/*.desktop; do
        [ -L "$link" ] || continue
        target=$(readlink -f "$link")
        rm "$link"

        sed '/^OnlyShowIn=/d;/^NoDisplay=/d' "$target" > "$link"
        echo 'NoDisplay=true' >> "$link"
      done
    fi
  '';
}
