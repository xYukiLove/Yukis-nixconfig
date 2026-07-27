{
  description = "Cleaning Up file";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    nixvim.url = "github:nix-community/nixvim";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    #kineticwe = {
      #url = "gitlab:theblackdon/kineticwe";
      #inputs.nixpkgs.follows = "nixpkgs";
    #};
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-stable,
    lanzaboote,
    spicetify-nix,
    prismlauncher,
    yazi,
    mangowm,
    nixvim,
    helium,
    nix-flatpak,
    noctalia,
    #kineticwe,
    ...
  }: {
    nixosConfigurations = {
      nixos-btw = nixpkgs.lib.nixosSystem {
        specialArgs = 
	let
	  system = "x86_64-linux";
	in {
	  inherit inputs;
	  pkgs-stable = import nixpkgs-stable {
	    inherit system;
	    config.allowUnfree = true;
	  };
	};
	modules = [
          ./configuration.nix
	  #inputs.kineticwe.nixosModules.default
	  inputs.mangowm.nixosModules.mango
	  spicetify-nix.nixosModules.spicetify
	  nixvim.nixosModules.nixvim
          lanzaboote.nixosModules.lanzaboote
	  nix-flatpak.nixosModules.nix-flatpak
          ({ pkgs, lib, ... }: {
	    environment.systemPackages = [
	      pkgs.sbctl
              inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
	      prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
	      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
	      (yazi.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
	        _7zz = pkgs._7zz-rar;
	      })
            ];
	    boot.loader.systemd-boot.enable = lib.mkForce false;
	    boot.lanzaboote = {
	      enable = true;
	      pkiBundle = "/var/lib/sbctl";
 	    };
	  })
	];
      };
    };
  };
}
