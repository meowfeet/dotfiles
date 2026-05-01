{ pkgs, user, ... }:

{
  environment.systemPackages = [ pkgs.discord ];

  environment.persistence.${user.persistPath}.users.${user.name} = {
    directories = [
      ".config/discord/${pkgs.discord.version}/modules" # module cache; avoids updates every launch
      { directory = ".config/discord/Local Storage/leveldb"; mode = "0700"; } # logins + session state
    ];

    files = [
      ".config/discord/settings.json"
    ];
  };
}
