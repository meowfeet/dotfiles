{ ... }:

{
  programs.dconf.enable = true;

  hm.dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    "org/gnome/desktop/wm/preferences".button-layout = "";
  };
}
