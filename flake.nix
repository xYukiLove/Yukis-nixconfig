{
  description = "Adding nixpkgs-stable.";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-26.05";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
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
    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{
  self,
  nixpkgs,
  nixpkgs-stable,
  lanzaboote,
  noctalia,
  home-manager,
  quickshell,
  spicetify-nix,
  prismlauncher,
  yazi,
  nix-cachyos-kernel,
  zen-browser,
  mangowm,
  ...
  }: {
    nixosConfigurations = {
      nixos-btw = nixpkgs.lib.nixosSystem {
        specialArgs = let
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
	./noctalia.nix
	inputs.mangowm.nixosModules.mango
        home-manager.nixosModules.home-manager
	inputs.spicetify-nix.nixosModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.allie = ./home.nix;
        }
        lanzaboote.nixosModules.lanzaboote
        ({ pkgs, lib, inputs, ... }: {
	  nixpkgs.overlays = [
	    nix-cachyos-kernel.overlays.default
	  ];
          environment.systemPackages = [
            pkgs.sbctl
	    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
            inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
	    prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
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
