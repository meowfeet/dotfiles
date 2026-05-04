{ lib, user, ... }:

{
  i18n.defaultLocale = user.locale;
  time.timeZone = user.timeZone;

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
