{ user, ... }:

{
  security.polkit.enable = true;

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
  '';
}
