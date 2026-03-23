{
  description = "Home Manager configuration";

  inputs = {
    # Increment release branch for NixOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      # Follow corresponding `release` branch from Home Manager
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv = {
      url = "github:cachix/devenv/v2.0.5";
    };
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
          modules = [ ./home ];
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
