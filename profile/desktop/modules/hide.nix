{ lib, pkgs, ... }:

let
  entriesFrom =
    pkg:
    map (lib.removeSuffix ".desktop")
        (builtins.attrNames (builtins.readDir "${pkg}/share/applications"));

  hide =
    [ ]
    ++ entriesFrom pkgs.cosmic-applets
    ++ entriesFrom pkgs.cosmic-applibrary
    ++ entriesFrom pkgs.cosmic-bg
    ++ entriesFrom pkgs.cosmic-launcher
    ++ entriesFrom pkgs.cosmic-notifications
    ++ entriesFrom pkgs.cosmic-settings
    ++ entriesFrom pkgs.cosmic-workspaces-epoch;
    # ++ [
    #   "geoclue-where-am-i"
    #   "nm-applet"
    #   "nm-connection-editor"
    #   "nvidia-settings"
    #   "org.freedesktop.Xwayland"
    #   "xdg-desktop-portal-gtk"
    # ];
in
{
  hm.xdg.desktopEntries = lib.genAttrs hide (name: {
    inherit name;
    noDisplay = true;
  });
}
