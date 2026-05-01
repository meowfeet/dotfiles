{ lib, user, ... }:

{
  imports = [
    ./apps
    ./desktop
  ];

  environment.persistence.${user.persistPath} = {
    enable = true;
    hideMounts = true;

    directories = [
      "/etc/nixos" # *this* system config
      "/var/lib/nixos" # remembers user/group ids
    ];

    files = [
      "/etc/machine-id" # identity for apps/services
    ];
  };

  i18n.defaultLocale = user.locale;
  time.timeZone = user.timeZone;

  users.users.${user.name} = {
    isNormalUser = true;
    description = lib.toSentenceCase user.name;
    password = user.password;
    extraGroups = [ "wheel" ];
  };

  users.mutableUsers = false;

  security.sudo = {
    wheelNeedsPassword = false;
    extraConfig = ''
      Defaults:${user.name} env_keep += "SSH_AUTH_SOCK"
    '';
  };

  programs.ssh.extraConfig = ''
    Host *
      StrictHostKeyChecking no
      UserKnownHostsFile /dev/null

    Host github.com
      HostName github.com
      User git
      IdentityFile ~/.ssh/git
  '';
}
