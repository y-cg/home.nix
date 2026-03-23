{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nix-tree # useful for analyzing nix closure
    nix-search-cli # search nix packages from binary name
    nix-output-monitor # monitor nix build output
    nixfmt # format nix files
    nixd # nix lsp
    nil # nix lsp
  ];
}
