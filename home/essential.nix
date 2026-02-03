{ pkgs, ... }:
{
  home.packages = with pkgs; [
    busybox
  ];
}
