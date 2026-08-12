{ config, pkgs, ... }:
{
  programs.mango.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    swaybg
    grim
    slurp
    wl-clipboard
    cava
    wlogout
    dmenu
    dunst
    fuzzel
    wmenu
    swaybg
  ];
}
