{ pkgs, user, ... }:

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

  environment.persistence.${user.persistPath}.users.${user.name} = {
    directories = [
      { directory = ".gnupg"; mode = "0700"; }
      { directory = ".local/share/keyrings"; mode = "0700"; }
      { directory = ".ssh"; mode = "0700"; }
    ];
  };
}
