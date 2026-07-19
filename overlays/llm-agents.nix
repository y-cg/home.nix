{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.llm-agents.overlays.shared-nixpkgs
  ];
}
