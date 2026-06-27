{ config, pkgs, inputs, pkgs-stable,... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./noctalia.nix
    ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fileSystems."/mnt/linuxgames" = {
    device = "UUID=187929c8-4308-4dae-9c0d-c25c3680f8c6";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" ]; # optional but common for btrfs
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  #pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4; #pkgs.linuxPackages_latest;
  networking.hostName = "nixos-btw"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable networking
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "America/New_York";
  # Select internationalisation properties.
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
  # WLmouse Sword X
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a879", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a879", MODE="0660", GROUP="input"
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a878", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a878", MODE="0660", GROUP="input"

  # WLmouse Beast X Mini Pro
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a868", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a868", MODE="0660", GROUP="input"
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a869", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a869", MODE="0660", GROUP="input"

  # WLmouse Beast X
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a883", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a883", MODE="0660", GROUP="input"
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a884", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="36a7", ATTRS{idProduct}=="a884", MODE="0660", GROUP="input"

  # EGG OP18K
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3367", ATTRS{idProduct}=="1964", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="3367", ATTRS{idProduct}=="1964", MODE="0660", GROUP="input"

  # G-Wolves HSK Pro 4k
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="5807", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="5807", MODE="0660", GROUP="input"
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="5808", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="33e4", ATTRS{idProduct}=="5808", MODE="0660", GROUP="input"

  # Corne V4
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="4653", ATTRS{idProduct}=="0004", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="4653", ATTRS{idProduct}=="0004", MODE="0660", GROUP="input"

  # Vault 35 WKL Pipboy
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="a457", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="1209", ATTRS{idProduct}=="a457", MODE="0660", GROUP="input"

  # Wooting 60HE+
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1322", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="31e3", ATTRS{idProduct}=="1322", MODE="0660", GROUP="input"

  # Finalmouse ULX Sakura
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="361d", ATTRS{idProduct}=="0100", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="361d", ATTRS{idProduct}=="0100", MODE="0660", GROUP="input"
  SUBSYSTEM=="hidraw", ATTRS{idVendor}=="361d", ATTRS{idProduct}=="0102", MODE="0660", GROUP="input"
  SUBSYSTEM=="usb", ATTRS{idVendor}=="361d", ATTRS{idProduct}=="0102", MODE="0660", GROUP="input"

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
'';
  # Enable udev rules
  services.udev.enable = true;
  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.displayManager.sddm.wayland = {
    enable = true;
  };
  #services.desktopManager.gnome.enable = true;
  #services.desktopManager.plasma6.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      common.default = [ "gnome" ];
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
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.allie = {
    isNormalUser = true;
    description = "Allie";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = with pkgs; [
    ];
  };
  programs.niri.enable = true;
  programs.mango.enable = true;
  services.flatpak.enable = true;
  programs.zsh.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
    ];
    theme = spicePkgs.themes.starryNight;
    colorScheme = "Base";
  };
  programs.neovim = {
    enable = true;
    configure = {
      customRC = ''
        set number
	set list
	set termguicolors
      '';
      };
  };
  programs.gamemode.enable = true;
  environment.variables = {
    XCURSOR_THEME = "Shinobu-Oshino";
    XCURSOR_SIZE = "24";
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    polkit_gnome
    kdePackages.dolphin
    zsh
    zsh-powerlevel10k
    fzf
    eza
    zoxide
    bat
    wget
    vesktop
    git
    kitty
    alacritty
    fastfetch
    vlc
    sbctl
    ani-cli
    krita
    brave
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
    foot
    wmenu
    wl-clipboard
    grim
    slurp
    swaybg
    waybar
    flameshot
    cava
    wlogout
    discord-canary
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
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 53317 ];
  networking.firewall.allowedUDPPorts = [ 53317 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.11"; # Did you read the comment?

}
