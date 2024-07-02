require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "nickel_ls",
    },
}

-- Setup language servers.
local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- backend should be installed via mason
lspconfig.lua_ls.setup { capabilities = lsp_capabilities }
lspconfig.nickel_ls.setup { capabilities = lsp_capabilities }

-- backend gets installed via nix shell
lspconfig.zls.setup { capabilities = lsp_capabilities }

vim.g.zig_fmt_autosave = 0; -- zig shall not destroy my files

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(args)
        -- enable inlay hints
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end

        -- Buffer local mappings.
        local opts = { buffer = args.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<space>fm', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
