{ ... }:
{
  # ==============================================================================
  # Nixpkgs Package Policy
  # ==============================================================================
  #
  # Home Manager evaluates `home.packages` through the `pkgs` set for this flake.
  # This setup intentionally mixes free and unfree developer tools, so we enable
  # unfree packages globally instead of maintaining a per-package allowlist.
  nixpkgs.config.allowUnfree = true;
}
