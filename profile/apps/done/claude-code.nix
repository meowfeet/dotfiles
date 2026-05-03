{ ... }:

{
  hm.programs.claude-code = {
    enable = true;

    settings = {
      skipDangerousModePermissionPrompt = true;
      theme = "dark";
    };
  };

  persist.directories = [
    { directory = ".claude"; mode = "0700"; }
  ];
}
