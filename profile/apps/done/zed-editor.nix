{ pkgs, ... }:

{
  persist.directories = [
    { directory = ".local/share/zed"; mode = "0700"; }
    ".config/zed"
  ];

  hm.programs.zed-editor = {
    enable = true;

    userSettings = {
      languages."Nix".language_servers = [ "nixd" "!nil" ];

      telemetry = {
        diagnostics = false;
        metrics = false;
      };
    };

    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];
  };
}
