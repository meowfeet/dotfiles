{ ... }:

{
  hm.wayland.desktopManager.cosmic.compositor.input_default = {
    state = {
      __type = "enum";
      variant = "Enabled";
    };

    acceleration = {
      __type = "optional";

      value = {
        profile = {
          __type = "optional";

          value = {
            __type = "enum";
            variant = "Flat";
          };
        };

        speed = 0.0;
      };
    };
  };
}
