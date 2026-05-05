{ ... }:

{
  programs.dconf.enable = true;

  hm.dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
}
