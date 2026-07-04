{ config, pkgs, inputs, pkgs-stable,... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fileSystems."/mnt/linuxgames" = {
    device = "UUID=84865633-a9a6-41c5-9998-870de2e1549d";
    fsType = "ext4";
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  #pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4; #pkgs.linuxPackages_latest;
  networking.hostName = "nixos-btw";
  users.users.yuki = {
    isNormalUser = true;
    description = "Yuki";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [
    ];
  };
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  networking.wireless.enable = true;
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
  services.udev.extraRules = ''
    # EGG OP18K
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3367", ATTRS{idProduct}=="1964", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="3367", ATTRS{idProduct}=="1964", MODE="0660", GROUP="input"
    # Corne V4
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="4653", ATTRS{idProduct}=="0004", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="4653", ATTRS{idProduct}=="0004", MODE="0660", GROUP="input"
    # Vault 35 WKL Pipboy
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="a457", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="a457", MODE="0660", GROUP="input"
    # MCHOSE L7 Ultra
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="5253", ATTRS{idProduct}=="1020", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="5253", ATTRS{idProduct}=="1020", MODE="0660", GROUP="input"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="5253", ATTRS{idProduct}=="00b1", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="5253", ATTRS{idProduct}=="00b1", MODE="0660", GROUP="input"
    # WLmouse Huan
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a863", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a863", MODE="0660", GROUP="input"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a864", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a864", MODE="0660", GROUP="input"
    # WLmouse Beast G Mini
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a860", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a860", MODE="0660", GROUP="input"
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a861", MODE="0660", GROUP="input"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a861", MODE="0660", GROUP="input"
  '';
  services.udev.enable = true;
  services.xserver.enable = true;
  #services.xserver.desktopManager.xfce.enable = true;
  #services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
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
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    SDL_VIDEODRIVER = "wayland";
    WLR_DRM_NO_ATOMIC = "1";
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr = {
      enable = true;
      settings = {
        screencast = {
	      max_fps = 60;
	      chooser_type = "dmenu";
	      chooser_cmd = "${pkgs.wofi}/bin/wofi --show dmenu";
	    };
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "gtk" ];
	    "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        "org.freedesktop.impl.portal.Inhibit" = [ "none" ];
      };
      wlroots = {
      };
    };
  };
  nix.settings = {
    extra-substituters = [
      "https://noctalia.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://prismlauncher.cachix.org"
      "https://yazi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "prismlauncher.cachix.org-1:9/n/FGyABA2jLUVfY+DEp4hKds/rwO+SCOtbOkDzd+c="
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
    ];
  };
  services.flatpak.enable = true;
  programs.zsh.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true;
  };
  programs.gamemode.enable = true;
  environment.variables = {
    XCURSOR_THEME = "Shinobu-Oshino";
    XCURSOR_SIZE = "24";
  };
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    blueman
    polkit_gnome
    kdePackages.dolphin
    zsh
    zsh-powerlevel10k
    fzf
    eza
    zoxide
    bat
    wget
    git
    kitty
    fastfetch
    vlc
    sbctl
    ani-cli
    krita
    usbutils
    xwayland-satellite
    fuzzel
    kdePackages.ark
    unrar
    btop
    cpufetch
    kdePackages.kate
    heroic
    ddcutil
    cachix
    localsend
    protonup-qt
    protontricks
    lm_sensors
    proton-vpn
    vial
    win2xcur
    xcursor-themes
    lact
    hyfetch
    tree
    librewolf
    wmenu
    wl-clipboard
    grim
    slurp
    swaybg
    waybar
    cava
    wlogout
    vscode
    obsidian
    lutris
    gamescope
    discord
    pavucontrol
    kdePackages.kdenlive
    dunst
    wofi
    dmenu
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
	    obs-backgroundremoval
	    obs-pipewire-audio-capture
      ];
    })
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
  ];
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
  system.stateVersion = "26.11";
}
