{ ... }:

{
  security.polkit.enable = true;

  security.sudo = {
    wheelNeedsPassword = false;

    extraConfig = ''
      Defaults env_keep += "SSH_AUTH_SOCK"
    '';
  };

  programs.ssh.extraConfig = ''
    Host *
      StrictHostKeyChecking no
      UserKnownHostsFile /dev/null
      LogLevel ERROR
  '';
}
