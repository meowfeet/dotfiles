{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  environment.sessionVariables = {
    AQ_DRM_DEVICES = "/dev/dri/by-path/pci-0000:01:00.0-card";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
