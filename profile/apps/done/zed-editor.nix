{ pkgs, ... }:

{
  persist.directories = [
    { directory = ".local/share/zed"; mode = "0700"; }
    ".config/zed"
  ];

  hm.programs.zed-editor = {
    enable = true;

    userSettings = {
      languages."Nix".language_servers = [ "nil" "!nixd" ];

      telemetry = {
        diagnostics = false;
        metrics = false;
      };
    };

    extraPackages = with pkgs; [
      nil
      nixfmt
    ];
  };
}
