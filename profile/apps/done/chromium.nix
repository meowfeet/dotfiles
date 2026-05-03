{
  lib,
  pkgs,
  user,
  ...
}:

{
  persist.directories = [
    { directory = ".config/chromium/Default"; mode = "0700"; }
  ];

  hm.programs.chromium = {
    enable = true;
    package = pkgs.chromium.override { enableWideVine = true; };

    commandLineArgs = [
      "--hide-crash-restore-bubble"
      "--no-default-browser-check"
      "--no-first-run"
    ];

    extensions = [
      { id = "edibdbjcniadpccecjdfdjjppcpchdlm"; } # I still don't care about cookies
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # uBlock Origin Lite
    ];
  };

  hm.xdg.mimeApps = {
    enable = true;

    defaultApplications = lib.genAttrs [
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ] (_: "chromium-browser.desktop");
  };

  programs.chromium = {
    enable = true;

    extraOpts = {
      # Autofill
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      PasswordManagerEnabled = false;

      # Extra features
      NewTabPageLocation = "https://www.google.com";
      TranslateEnabled = false;

      # Permissions
      DefaultGeolocationSetting = 2;
      DefaultNotificationsSetting = 2;

      # Profiles
      BrowserAddPersonEnabled = false;
      BrowserGuestModeEnabled = false;
      ProfilePickerOnStartupAvailability = 1;

      # Sign in
      BrowserSignin = 0;
      SyncDisabled = true;

      # Spellcheck
      SpellcheckEnabled = true;
      SpellcheckLanguage = user.browser.locales;
    };
  };
}
