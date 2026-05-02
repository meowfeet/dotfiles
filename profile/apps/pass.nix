{ pkgs, user, ... }:

{
  environment.systemPackages = [ pkgs.pass ];

  environment.persistence.${user.persistPath}.users.${user.name} = {
    directories = [
      { directory = ".gnupg"; mode = "0700"; }
      { directory = ".password-store"; mode = "0700"; }
    ];
  };
}
