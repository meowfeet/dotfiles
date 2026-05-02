{ ... }:

{
  imports = [
    ./apps
    ./desktop
  ];

  hm.programs.ssh.enable = true;
}
