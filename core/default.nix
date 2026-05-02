{ user, ... }:

{
  imports = [
    ./audio
    ./hardware
    ./network
    ./nix
    ./persistence
    ./security
    ./user
  ];

  i18n.defaultLocale = user.locale;
  time.timeZone = user.timeZone;
}
