{ config, pkgs, inputs, pkgs-stable, lib, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./nixosModules/nixvim.nix
      ./nixosModules/peripherials.nix
      ./nixosModules/xdg.nix
      ./nixosModules/spicetify.nix
      ./nixosModules/mangowm.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fileSystems."/mnt/linuxgames" = {
    device = "UUID=84865633-a9a6-41c5-9998-870de2e1549d";
    fsType = "ext4";
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.kernelPackages = pkgs.unstable.linuxPackages_latest;
  #boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;
  networking.hostName = "nixos-btw";
  users.users.yuki = {
    isNormalUser = true;
    description = "Yuki";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [
      kdePackages.ark
      kdePackages.kdenlive
    ];
  };
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
  services.xserver.displayManager.startx.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  nix.settings = {
    extra-substituters = [
      "https://nix-gaming.cachix.org"
      "https://prismlauncher.cachix.org"
      "https://yazi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
  };
  programs.zsh.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;
  environment.variables = {
    XCURSOR_THEME = "Shinobu-Oshino";
    XCURSOR_SIZE = "32";
  };
  services.flatpak = {
    enable = true;
    packages = [
      "org.vinegarhq.Sober"
      "com.boxy_svg.BoxySVG"
      "com.discordapp.Discord"
    ];
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    ani-cli
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
    ghostty
    git
    gnome.gvfs
    gvfs
    heroic
    hyfetch
    kitty
    krita
    lm_sensors
    localsend
    osu-lazer-bin
    pavucontrol
    pkgs.unstable.librewolf
    pkgs.unstable.nwg-look
    pkgs.unstable.vesktop
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
    zsh
    zsh-powerlevel10k
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
