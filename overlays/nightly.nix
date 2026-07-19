{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      # Pull neovim from nixpkgs nightly (master) channel instead of neovim-nightly-overlay
      neovim = inputs.nixpkgs-nightly.legacyPackages.${prev.system}.neovim;
    })
  ];
}
