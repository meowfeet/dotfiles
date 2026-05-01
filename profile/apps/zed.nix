{ pkgs, user, ... }:

{
  environment.systemPackages = with pkgs; [
    codex-acp
    nixd
    nixfmt
    zed-editor
  ];

  environment.persistence.${user.persistPath}.users.${user.name} = {
    directories = [
      ".local/share/zed/extensions"
    ];

    files = [
      ".config/zed/settings.json"
      { file = ".codex/auth.json"; parentDirectory.mode = "0700"; }
    ];
  };
}
