{ pkgs, ... }:

{
  hm.home.packages = [ pkgs.pass ];

  persist.directories = [
    { directory = ".gnupg"; mode = "0700"; }
    { directory = ".password-store"; mode = "0700"; }
  ];
}
