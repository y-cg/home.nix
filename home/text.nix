{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # search & find & replace
    ripgrep
    fd
    sd
    jless # less for json
  ];
}
