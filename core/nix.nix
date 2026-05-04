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

    auto-optimise-store = true;
    warn-dirty = false;
  };
}
