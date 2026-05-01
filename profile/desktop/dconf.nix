{ lib, pkgs, ... }:

/*
  let
    hide = name: exec:
      lib.hiPrio (pkgs.writeTextDir "share/applications/${name}.desktop" ''
        [Desktop Entry]
        Type=Application
        Name=${name}
        Exec=${exec}
        NoDisplay=true
      '');
  in
*/
{
  # environment.systemPackages = [
  #   (hide "nvidia-settings" "nvidia-settings")
  #   (hide "org.gnome.Console" "kgx")
  #   (hide "org.gnome.Settings" "gnome-control-center")
  # ];

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
          "org/gnome/Console" = {
            transparency = true;
          };

          "org/gnome/desktop/background" = {
            picture-uri = "file://${../wallpaper.png}";
            picture-uri-dark = "file://${../wallpaper.png}";
          };

          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
          };

          "org/gnome/desktop/notifications" = {
            show-banners = false;
            show-in-lock-screen = false;
          };

          "org/gnome/desktop/peripherals/mouse" = {
            accel-profile = "flat";
          };

          "org/gnome/desktop/screensaver" = {
            lock-enabled = false;
          };

          "org/gnome/desktop/session" = {
            idle-delay = lib.gvariant.mkUint32 0;
          };

          "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:";
          };

          "org/gnome/settings-daemon/plugins/housekeeping" = {
            donation-reminder-enabled = false;
          };

          "org/gnome/shell" = {
            enabled-extensions = [
              pkgs.gnomeExtensions.blur-my-shell.extensionUuid
            ];
            favorite-apps = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          };

          "org/gnome/shell/extensions/blur-my-shell/applications" = {
            blur = true;
            enable-all = false;
            whitelist = [ "org.gnome.Console" ];
          };
        };
      }
    ];
  };
}
