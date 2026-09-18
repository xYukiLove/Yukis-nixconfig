{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./nixosModules/nixvim.nix
      ./nixosModules/spicetify.nix
      ./nixosModules/mangowm.nix
      ./nixosModules/zsh.nix
      ./nixosModules/xdg.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.kernelPackages = pkgs.unstable.linuxPackages_latest;
  networking.hostName = "mrrp";
  networking.networkmanager.enable = true;
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
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    open = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      amdgpuBusId = "PCI:5:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
  services.upower.enable = true;
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
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
  users.users."iris" = {
    isNormalUser = true;
    description = "iris";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      krita
    ];
  };
  environment.variables = {
    XCURSOR_THEME = "Shinobu-Oshino";
    XCURSOR_SIZE = "32";
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
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.plugins = with pkgs; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.flatpak = {
    enable = true;
    packages = [
      "org.vinegarhq.Sober"
      "com.discordapp.Discord"
    ];
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
    tree
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
