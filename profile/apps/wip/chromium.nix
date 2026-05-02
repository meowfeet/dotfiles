{
  lib,
  pkgs,
  user,
  ...
}:

{
  hm.home.packages = [
    (pkgs.chromium.override {
      enableWideVine = true;
      commandLineArgs = [
        "--no-default-browser-check"
        "--no-first-run"
      ];
    })
  ];

  programs.chromium = {
    enable = true;
    extensions = [
      "edibdbjcniadpccecjdfdjjppcpchdlm" # I still don't care about cookies
      "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
    ];
    extraOpts = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      PasswordManagerEnabled = false;

      NewTabPageLocation = "https://www.google.com";
      TranslateEnabled = false;

      DefaultGeolocationSetting = 2;
      DefaultNotificationsSetting = 2;

      BrowserAddPersonEnabled = false;
      BrowserGuestModeEnabled = false;
      ProfilePickerOnStartupAvailability = 1;

      BrowserSignin = 0;
      SyncDisabled = true;

      SpellcheckEnabled = true;
      SpellcheckLanguage = user.browser.locales;
    };
  };

  xdg.mime = {
    enable = true;
    defaultApplications = lib.genAttrs [
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ] (_: "chromium-browser.desktop");
  };

  persist.directories = [
    { directory = ".config/chromium/Default"; mode = "0700"; }
  ];
}
