{ pkgs, lib, inputs, ... }:
{
  programs.nixvim = {
    enable = true;
    colorschemes.kanagawa-paper.enable = true;
    globals.mapleader = " ";
    opts = {
      number = true;
      shiftwidth = 2;
    };
    plugins.colorizer = {
      enable = true;
      settings = {
        user_default_options = {
      	  css = true;
	  css_fn = true;
	  rgb = true;
	  hsl = true;
	  names = true;
	  tailwind = true;
	  mode = "background";
        };
      };
    };
  };
}
