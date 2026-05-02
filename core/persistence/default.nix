{ user, ... }:

{
  environment.persistence.${user.persistPath} = {
    enable = true;
    hideMounts = true;

    directories = [
      "/etc/nixos" # *this* system config
      "/var/lib/nixos" # remembers user/group ids
    ];

    files = [
      "/etc/machine-id" # identity for apps/services
    ];

    users.${user.name} = {
      directories = [
        { directory = ".ssh"; mode = "0700"; }
      ];
    };
  };
}
