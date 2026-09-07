{ config, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./nixosModules/nixvim.nix
      ./nixosModules/spicetify.nix
      ./nixosModules/hyprland.nix
      ./nixosModules/peripherials.nix
      ./nixosModules/zsh.nix
    ];
  boot.loader.limine.enable = true;
  boot.loader.limine.secureBoot.enable = true;
  boot.loader.limine.extraEntries = ''
    /Windows
      protocol: efi
      path: uuid(47e51e77-37c9-4049-834e-2b1cc323d2ba):/EFI/Microsoft/Boot/bootmgfw.efi
  '';
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.unstable.linuxPackages_latest;
  fileSystems."/mnt/linuxgames" = {
    device = "UUID=84865633-a9a6-41c5-9998-870de2e1549d";
    fsType = "ext4";
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "nixos-btw";
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  networking.wireless.enable = true;
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  users.users."luna" = {
    isNormalUser = true;
    description = "luna";
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [
      kdePackages.kdenlive
      krita
      emojipick
    ];
  };
  environment.variables = {
    XCURSOR_THEME = "Shinobu-Oshino";
    XCURSOR_SIZE = "32";
  };
  services.flatpak = {
    enable = true;
    packages = [
      "org.vinegarhq.Sober"
      "com.discordapp.Discord"
    ];
  };
  nix.settings = {
    extra-substituters = [
      "https://nix-gaming.cachix.org"
      "https://prismlauncher.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
    ];
  };
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    adw-gtk3
    ani-cli
    vim
    bat
    blueman
    bolt-launcher
    btop
    cachix
    cbonsai
    ddcutil
    fastfetch
    faugus-launcher
    gamescope
    obsidian
    cmake
    gcc
    git
    gnome.gvfs
    gvfs
    heroic
    hyfetch
    kitty
    lm_sensors
    localsend
    osu-lazer-bin
    pavucontrol
    vesktop
    polkit_gnome
    protontricks
    protonup-qt
    ristretto
    sbctl
    thunar
    thunar-volman
    tree
    tumbler
    unrar
    usbutils
    vial
    vlc
    wget
    win2xcur
    xcursor-themes
    xwayland-satellite
    nwg-look
    fzf
    papirus-icon-theme
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
	obs-backgroundremoval
	obs-pipewire-audio-capture
      ];
    })
  ];
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
      maple-mono.NF
      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Maple Mono NF" ];
	sansSerif = [ "Maple Mono NF" ];
	serif = [ "Maple Mono NF" ];
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
  system.stateVersion = "26.05";
}
