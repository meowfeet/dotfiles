{ user, ... }:

{
  environment.persistence.${user.persistPath} = {
    enable = true;
    hideMounts = true;

    directories = [
      { directory = "/etc/nixos"; user = user.name; group = user.group; } # *this* system config
      "/var/lib/nixos" # remembers user/group ids
    ];

    files = [
      "/etc/machine-id" # identity for apps/services
    ];

    # critical shared paths most tools expect
    users.${user.name} = {
      directories = [
        { directory = ".local/share/keyrings"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
      ];
    };
  };
}
