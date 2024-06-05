{
  description = "Nixos config flake";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-24.05"; };
    unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, sops-nix, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs;
    in
    {

      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.default
          sops-nix.nixosModules.sops
        ];
      };

      nixosConfigurations.xps = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/xps/configuration.nix
          inputs.home-manager.nixosModules.default
          sops-nix.nixosModules.sops
        ];
      };

    };
}
