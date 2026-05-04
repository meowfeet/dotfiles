{ pkgs, ... }:

{
  stylix = {
    enable = true;

    image = ../wallpaper.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    fonts.sizes.popups = 14;

    opacity = {
      terminal = 0.90;
      popups = 0.90;
    };
  };
}
