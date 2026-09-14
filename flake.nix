{
  description = "Home Manager configuration";

  nixConfig = {
    extra-substituters = [
      "https://devenv.cachix.org"
      "https://cache.numtide.com"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.2605.*.tar.gz";
    nixpkgs-nightly.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";
    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.2605.*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix4nvchad = {
      url = "github:nix-community/nix4nvchad";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nvchad-starter.follows = "nvchad-config";
    };
    nvchad-config = {
      url = "github:y-cg/nvchad";
      flake = false;
    };
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      mkHome =
        { meta }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${meta.platform};
          modules = [
            ./home
            ./overlays
          ];
          extraSpecialArgs = { inherit meta inputs; };
        };
      whoami = "ycg";
    in

    {
      homeConfigurations."${whoami}@x86" = mkHome {
        meta = {
          platform = "x86_64-linux";
          inherit whoami;
        };
      };

      homeConfigurations."${whoami}@arm" = mkHome {
        meta = {
          platform = "aarch64-linux";
          inherit whoami;
        };
      };

    };
}
