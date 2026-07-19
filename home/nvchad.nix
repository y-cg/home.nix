{ inputs, pkgs, ... }:
{

  imports = [ inputs.nix4nvchad.homeManagerModule ];
  programs.nvchad = {
    enable = true;
    extraPackages = [ ];
    hm-activation = true;
    backup = false;
    # neovim is now provided by the overlay in overlays/neovim.nix (from nixpkgs-master)
    neovim = pkgs.neovim;
  };

}
