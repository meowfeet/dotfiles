{
  lib,
  pkgs,
  user,
  ...
}:

{
  environment.systemPackages = [
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

  environment.persistence.${user.persistPath}.users.${user.name} = {
    directories = [
      { directory = ".config/chromium/Default"; mode = "0700"; } # logins + state needed for browser stability
    ];
  };

  xdg.mime = {
    enable = true;
    defaultApplications = lib.genAttrs [
      "text/html"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ] (_: "chromium-browser.desktop");
  };
}
