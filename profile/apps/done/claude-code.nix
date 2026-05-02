{ ... }:

{
  hm.programs.claude-code = {
    enable = true;

    settings = {
      skipDangerousModePermissionPrompt = true;
    };
  };

  persist.directories = [
    { directory = ".claude"; mode = "0700"; }
  ];
}
