{ pkgs, ... }:

{
  services.gnome.core-apps.enable = false;
  services.gnome.gnome-initial-setup.enable = false;

  environment.gnome.excludePackages = with pkgs; [
    gnome-bluetooth
    gnome-tour
    gnome-user-docs
  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnome-calculator
    gnome-console
    gnome-text-editor
    nautilus
  ];
}
