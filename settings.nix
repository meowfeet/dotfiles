{
  name = "meowfeet";
  email = "279364940+meowfeet@users.noreply.github.com";
  password = "realpassword";

  locale = "en_DK.UTF-8";
  timeZone = "Europe/Copenhagen";

  keyboard = {
    layout = "us";
    variant = "altgr-intl";
  };

  browser = {
    locales = [
      "da"
      "en-US"
    ];
  };

  # nvidia only
  graphics = {
    primary = "/dev/dri/by-path/pci-0000:01:00.0-card";
    backup = "/dev/dri/by-path/pci-0000:12:00.0-card";
  };

  persistPath = "/persist";
  scriptPrefix = "nix";
}
