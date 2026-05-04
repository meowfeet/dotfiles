{ pkgs, ... }:

{
  stylix = {
    enable = true;

    image = ../wallpaper.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts.sizes.popups = 14;

    opacity = {
      terminal = 0.90;
      popups = 0.90;
    };
  };
}
