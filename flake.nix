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
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      mkHome =
        { meta }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${meta.platform};
          modules = [ ./home ];
          extraSpecialArgs = { inherit meta; };
        };
      whoami = "ycg";
    in

    {
      homeConfigurations."${whoami}@general-x86" = mkHome {
        meta = {
          platform = "x86_64-linux";
          inherit whoami;
        };
      };

      homeConfigurations."${whoami}@general-arm" = mkHome {
        meta = {
          platform = "aarch64-linux";
          inherit whoami;
        };
      };

    };
}
