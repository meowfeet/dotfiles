{ user, ... }:

{
  hm.programs.git = {
    enable = true;

    settings = {
      user.name = user.name;
      user.email = user.email;
      safe.directory = "*";
    };
  };

  hm.programs.ssh.matchBlocks.github = {
    host = "github.com";
    user = "git";
    identityFile = "~/.ssh/git";
  };
}
