{ inputs, pkgs, ... }:
{

  imports = [ inputs.nix4nvchad.homeManagerModule ];
  programs.nvchad = {
    enable = true;
    extraPackages = [ ];
    hm-activation = true;
    backup = false;
    neovim = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

}
