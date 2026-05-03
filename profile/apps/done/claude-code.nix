{ ... }:

{
  persist.directories = [
    { directory = ".claude"; mode = "0700"; }
  ];

  persist.files = [
    ".claude.json"
  ];

  hm.programs.claude-code = {
    enable = true;

    settings = {
      skipDangerousModePermissionPrompt = true;
    };
  };
}
