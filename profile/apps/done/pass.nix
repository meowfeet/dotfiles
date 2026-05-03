{ pkgs, ... }:

{
  persist.directories = [
    { directory = ".gnupg"; mode = "0700"; }
    { directory = ".password-store"; mode = "0700"; }
  ];

  hm.home.packages = [ pkgs.pass ];
}
