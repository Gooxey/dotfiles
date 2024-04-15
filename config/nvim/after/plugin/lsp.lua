local lsp_zero = require('lsp-zero')
local lspconfig = require("lspconfig")

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

-- language servers
require('mason').setup{}
require('mason-lspconfig').setup{
  ensure_installed = {
      "lua_ls",
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
}

lspconfig.zls.setup{}
lspconfig.rust_analyzer.setup{}
