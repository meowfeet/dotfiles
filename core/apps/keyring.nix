{ ... }:

{
  persist.directories = [
    { directory = ".local/share/keyrings"; mode = "0700"; }
  ];

  services.gnome.gnome-keyring.enable = true;
}
