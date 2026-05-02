{ ... }:

{
  imports = [
    ./apps
    ./desktop
  ];

  programs.ssh.extraConfig = ''
    Host github.com
      HostName github.com
      User git
      IdentityFile ~/.ssh/git
  '';
}
