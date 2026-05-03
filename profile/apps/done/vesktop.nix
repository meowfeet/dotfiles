{ pkgs, ... }:

{
  persist.directories = [
    { directory = ".config/vesktop"; mode = "0700"; }
  ];

  hm.home.packages = [ pkgs.vesktop ];
}
