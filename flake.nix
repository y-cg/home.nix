{
  description = "Home Manager configuration";

  nixConfig = {
    extra-substituters = [
      "https://cachix.cachix.org"
      "https://devenv.cachix.org"
      "https://cache.numtide.com"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    # Increment release branch for NixOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      # Follow corresponding `release` branch from Home Manager
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv = {
      url = "github:cachix/devenv/v2.0.6";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
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
