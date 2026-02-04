{ pkgs, ... }:
{
  home.packages = with pkgs; [
    less
  ];
}
