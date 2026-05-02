{ lib, user, ... }:

{
  users.users.${user.name} = {
    isNormalUser = true;

    password = user.password;
    description = lib.toSentenceCase user.name;
    extraGroups = [ "wheel" ];
  };

  users.mutableUsers = false;
}
