{ inputs, pkgs, ... }: {
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  home.packages = with pkgs; [
    # required by telescope
    ripgrep
    fd
  ];

  # nixvim as default editor
  programs.bash.sessionVariables.EDITOR = "nvim";

  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;

    globals.mapleader = " ";

    plugins = {
      treesitter.enable = true;
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
        };
      };
      todo-comments.enable = true;

      # quality-of-life
      auto-save.enable = true;
      nvim-autopairs.enable = true;
      comment-nvim.enable = true;
      which-key.enable = true;
      inc-rename.enable = true;
      # luasnip.enable = true; # required by nvim-cmp
      nvim-cmp = {
        enable = true;
        completion.autocomplete = [ "TextChanged" ];
        snippet.expand = "luasnip";
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        view = {
          docs.autoOpen = true;
          entries = {
            name = "custom";
            selection_order = "near_cursor";
          };
        };
        formatting= {
          fields = [ "abbr" "kind" ];
          format = ''
            function(_, vim_item)
              vim_item.menu = ""
              return vim_item
            end
          '';
        };

        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-e>" = "cmp.mapping.close()";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-Tab>" = {
            action = "cmp.mapping.select_prev_item()";
            modes = [
              "i"
              "s"
            ];
          };
          "<Tab>" = {
            action = "cmp.mapping.select_next_item()";
            modes = [
              "i"
              "s"
            ];
          };
        };
      };

      # visual
      airline.enable = true;
      indent-blankline.enable = true;
      illuminate.enable = true;
      gitsigns.enable = true;

      # languages
      lsp.enable = true;

      rust-tools.enable = true;

      # nix.enable = true;
      lsp.servers.nil_ls.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      nvim-dap # required by rustaceanvim

      nvim-web-devicons
    ];

    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 4;
    };
  };
}
