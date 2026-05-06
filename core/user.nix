{ lib, user, ... }:

{
  i18n.defaultLocale = user.locale;
  time.timeZone = user.timeZone;
  services.xserver.xkb = user.keyboard;

  users.users.${user.name} = {
    isNormalUser = true;

    password = user.password;
    description = lib.toSentenceCase user.name;
    extraGroups = [ "wheel" ];
  };

  users.mutableUsers = false;

  security.polkit.enable = true;
  security.sudo.wheelNeedsPassword = false;
}
