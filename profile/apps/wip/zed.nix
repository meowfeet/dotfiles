{ pkgs, ... }:

{
  hm.programs.zed-editor = {
    enable = true;

    userSettings = {
      languages."Nix".language_servers = [ "nixd" "!nil" ];

      telemetry = {
        diagnostics = false;
        metrics = false;
      };
    };
  };

  persist.directories = [
    { directory = ".local/share/zed"; mode = "0700"; }
    ".config/zed"
  ];

  hm.home.packages = with pkgs; [
    nixd
    nixfmt
  ];
}
