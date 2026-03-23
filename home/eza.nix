{
  pkgs,
  lib,
  ...
}:
{

  home.packages = with pkgs; [
    eza
  ];

  programs.zsh = {
    shellAliases = {
      ls = "${lib.getExe pkgs.eza} --follow-symlinks";
    };
  };
}
