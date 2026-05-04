{ theme, ... }:

{
  hm.programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = theme.font.spec.adjusted;
        width = 48;
        lines = 10;
        line-height = 48;
      };
      colors = {
        background = theme.colors.background.raw.alpha.hex;
        text = theme.colors.highlight.raw.alpha.default;
        match = theme.colors.accent.raw.alpha.default;
        selection = theme.colors.primary.raw.alpha.default;
        selection-text = theme.colors.highlight.raw.alpha.default;
        selection-match = theme.colors.accent.raw.alpha.default;
        border = theme.colors.primary.raw.alpha.default;
      };
    };
  };
}
