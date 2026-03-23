{
  pkgs,
  lib,
  ...
}:
{

  home.packages = with pkgs; [
    bat
  ];

  programs.zsh = {
    shellAliases = {
      cat = lib.getExe pkgs.bat;
    };
  };
}
