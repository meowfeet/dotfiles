{ ... }:

{
  hm.programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };

  programs.ssh.extraConfig = ''
    Host *
      StrictHostKeyChecking no
      UserKnownHostsFile /dev/null
      LogLevel ERROR
  '';

  persist.directories = [
    { directory = ".ssh"; mode = "0700"; }
  ];

  security.sudo.extraConfig = ''
    Defaults env_keep += "SSH_AUTH_SOCK"
  '';
}
