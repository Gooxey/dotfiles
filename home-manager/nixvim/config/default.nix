{ pkgs, ... }:
{
  plugins = import ./plugins;
  opts = import ./opts.nix;
  keymaps = import ./keymaps.nix;

  enable = true;

  extraPlugins = [
    pkgs.vimPlugins.asyncrun-vim
  ];

  colorschemes.gruvbox.enable = true;
  extraConfigLua = ''
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  '';

  globals.mapleader = " ";
  clipboard = {
    register = "unnamedplus";
    providers.xclip.enable = true;
  };

  performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      initLua = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
}
