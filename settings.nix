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

  # command: niri msg outputs
  monitor = {
    name = "DP-2";
    width = 1920;
    height = 1080;
    refresh = 144.001;
  };

  browser = {
    locales = [
      "da"
      "en-US"
    ];
  };

  persistPath = "/persist";
  scriptPrefix = "nix";
}
