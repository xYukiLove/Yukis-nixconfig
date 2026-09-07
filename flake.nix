{
  description = "Restructuring Flakes";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-unstable,
    spicetify-nix,
    prismlauncher,
    nixvim,
    helium,
    nix-flatpak,
    noctalia,
    nix-cachyos-kernel,
    hyprland,
    ...
  }: 
  {
    nixosConfigurations = {
      nixos-btw = nixpkgs.lib.nixosSystem {
        specialArgs = 
	    let
          system = "x86_64-linux";
	    in {
          inherit inputs;
        };
        modules = [
          ./configuration.nix
	      ./nixosModules/spicetify.nix
	      ./nixosModules/nixvim.nix
	      ./nixosModules/hyprland.nix
	      spicetify-nix.nixosModules.spicetify
	      nixvim.nixosModules.nixvim
	      nix-flatpak.nixosModules.nix-flatpak
	      ({ pkgs, lib, ... }:
	      {
	        nixpkgs.overlays = [
	          (final: prev: {
	            unstable = import inputs.nixpkgs-unstable {
		          system = final.stdenv.hostPlatform.system;
		          config.allowUnfree = true;
		        };
	          })
	          nix-cachyos-kernel.overlays.default
	        ];
	        environment.systemPackages = [
	          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
	          prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
	          inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
            ];
	      })
        ];
      };
    };
  };
}
