{ pkgs, user, ... }:

{
  environment.systemPackages = [ pkgs.git ];

  environment.etc."gitconfig".text = ''
    [user]
      name = ${user.name}
      email = ${user.email}
    [safe]
      directory = *
  '';
}
