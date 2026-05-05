{ user, ... }:

{
  systemd.tmpfiles.rules = [
    "L+ /var/lib/AccountsService/icons/${user.name} - - - - ${./avatar.png}"
    "f+ /var/lib/AccountsService/users/${user.name} 0600 root root - [User]\\nIcon=/var/lib/AccountsService/icons/${user.name}\\n"
  ];
}
