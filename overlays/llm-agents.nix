{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.llm-agents.overlays.default
  ];
}
