{ pkgs, ... }:

{
  imports = [
    ./chromium.nix
    ./discord.nix
    ./git.nix
    ./pass.nix
    ./zed.nix
  ];

  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
}
