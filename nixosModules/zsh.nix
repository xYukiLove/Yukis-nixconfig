{ config, lib, pkgs, ... }:
{
  users.defaultUserShell = pkgs.unstable.zsh;
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    interactiveShellInit = lib.mkAfter ''
      source ${pkgs.zsh-autocomplete}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
    '';
    #promptInit = ''
     # source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    #'';
    shellAliases = {
      nixconf = "sudo nvim /etc/nixos/configuration.nix";
      flakeconf = "sudo nvim /etc/nixos/flake.nix";
      upflake = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-btw";
      fastconfig = "nvim ~/.config/fastfetch/config.jsonc";
      hyprconfig = "nvim ~/.config/hypr/hyprland.lua";
      nixmods = "cd /etc/nixos/nixosModules";
    };
    ohMyZsh = {
      enable = true;
      theme = "half-life";
      plugins = [ "git" "z" ];
    };
  };
  environment.systemPackages = with pkgs; [
    zsh-autocomplete
    zsh-powerlevel10k
    pkgs.unstable.zsh
  ];
}
