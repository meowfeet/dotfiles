{ ... }:

{
  services.gnome.gnome-keyring.enable = true;

  persist.directories = [
    { directory = ".local/share/keyrings"; mode = "0700"; }
  ];
}
