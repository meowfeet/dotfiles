{ ... }:

{
  hm.programs.claude-code = {
    enable = true;

    settings = {
      theme = "dark";
      skipDangerousModePermissionPrompt = true;
    };
  };

  persist.directories = [
    { directory = ".claude"; mode = "0700"; }
  ];
}
