{ ... }:

{
  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;

  nix.channel.enable = false;
  nix.nixPath = [ ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    warn-dirty = false;
  };

  nix.gc = {
    automatic = true;

    dates = "daily";
    options = "--delete-older-than 7d";
  };

  nix.optimise = {
    automatic = true;

    dates = "daily";
  };
}
