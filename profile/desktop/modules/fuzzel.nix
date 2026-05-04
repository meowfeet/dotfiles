{ ... }:

{
  hm.programs.fuzzel.enable = true;

  hm.xdg.desktopEntries = {
    foot            = { name = "foot";            noDisplay = true; };
    foot-server     = { name = "foot-server";     noDisplay = true; };
    footclient      = { name = "footclient";      noDisplay = true; };
    kvantummanager  = { name = "kvantummanager";  noDisplay = true; };
    nvidia-settings = { name = "nvidia-settings"; noDisplay = true; };
    qt5ct           = { name = "qt5ct";           noDisplay = true; };
    qt6ct           = { name = "qt6ct";           noDisplay = true; };
  };
}
