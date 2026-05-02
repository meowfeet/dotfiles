{ user, ... }:

{
  hm.programs.git = {
    enable = true;

    userName = user.name;
    userEmail = user.email;
    extraConfig.safe.directory = "*";
  };

  hm.programs.ssh.matchBlocks.github = {
    host = "github.com";
    user = "git";
    identityFile = "~/.ssh/git";
  };
}
