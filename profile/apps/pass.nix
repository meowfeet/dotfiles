{ pkgs, user, ... }:

{
  environment.systemPackages = [ pkgs.pass ];

  environment.persistence.${user.persistPath}.users.${user.name} = {
    directories = [
      { directory = ".password-store"; mode = "0700"; }
    ];
  };
}
