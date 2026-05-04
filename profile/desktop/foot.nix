{ theme, ... }:

{
  hm.programs.foot = {
    enable = true;

    settings = {
      main.font = theme.font.spec.default;

      colors-dark = {
        foreground = theme.colors.highlight.raw.value;
        background = theme.colors.background.raw.value;
        alpha = theme.colors.alpha.float;
      };
    };
  };
}
