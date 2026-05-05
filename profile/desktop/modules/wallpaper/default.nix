{ ... }:

{
  hm.wayland.desktopManager.cosmic.wallpapers = [
    {
      output = "all";

      source = {
        __type = "enum";
        variant = "Path";
        value = [ "${./wallpaper.png}" ];
      };

      scaling_mode = {
        __type = "enum";
        variant = "Zoom";
      };

      filter_method = {
        __type = "enum";
        variant = "Lanczos";
      };

      filter_by_theme = false;
      rotation_frequency = 0;

      sampling_method = {
        __type = "enum";
        variant = "Alphanumeric";
      };
    }
  ];
}
