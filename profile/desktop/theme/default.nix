{ ... }:

{
  _module.args.theme = {
    colors = (rec {
      alpha = {
        hex = "e6";
        float = 0.90;
        default = "ff";
      };

      withAlpha = base: {
        value = base;
        alpha = alpha // {
          hex = "${base}${alpha.hex}";
          default = "${base}${alpha.default}";
        };
      };

      result = builtins.mapAttrs (_: raw: {
        raw = withAlpha raw;
        hex = withAlpha "#${raw}";
      }) {
        primary = "0650C9";
        secondary = "0A219C";
        accent = "09AFEF";
        highlight = "73E2D4";
        background = "051656";
      } // { inherit alpha; };
    }).result;

    font = (rec {
      family = "monospace";

      size = {
        default = 11;
        adjusted = 14;
      };

      result = {
        inherit family size;
        spec = builtins.mapAttrs (_: s: "${family}:size=${toString s}") size;
      };
    }).result;

    wallpaper = ./wallpaper.png;
  };
}
