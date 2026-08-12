{ pkgs, lib, inputs, ... }: 
{
  imports = [
    inputs.mangowm.nixosModules.mango
    inputs.spicetify-nix.nixosModules.spicetify
    inputs.nixvim.nixosModules.nixvim
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.nix-flatpak.nixosModules.nix-flatpak
  ];
  nixpkgs.overlays = [
    (final: prev: {
      unstable  = import inputs.nixpkgs-unstable {
        system = final.stdenv.hostPlatform.system;
	config.allowUnfree = true;
      };
    })
    inputs.nix-cachyos-kernel.overlays.default
  ];
  environment.systemPackages = [
    pkgs.sbctl
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.prismlauncher.packages.${pkgs.stdenv.hostPlatform.system}.prismlauncher
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    (inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      _7zz = pkgs._7zz-rar;
    })
  ];
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
}
