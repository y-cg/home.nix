{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    inputs.devenv.packages.${stdenv.hostPlatform.system}.default
  ];
  programs.direnv.enable = true;
}
