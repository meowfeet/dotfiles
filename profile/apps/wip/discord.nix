{ pkgs, ... }:

{
  hm.home.packages = [ pkgs.discord ];

  persist.directories = [
    ".config/discord/${pkgs.discord.version}/modules" # module cache; avoids updates every launch
    { directory = ".config/discord/Local Storage/leveldb"; mode = "0700"; } # logins + session state
  ];

  persist.files = [
    ".config/discord/settings.json"
  ];
}
