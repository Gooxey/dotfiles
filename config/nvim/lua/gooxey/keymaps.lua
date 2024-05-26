vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>G", vim.cmd.Neogit)

-- toggle term
vim.keymap.set("n", "<leader>t", vim.cmd.ToggleTerm)
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

-- pane switching
vim.keymap.set('n', '<leader>h', [[<C-w><C-h>]])
vim.keymap.set('n', '<leader>j', [[<C-w><C-j>]])
vim.keymap.set('n', '<leader>k', [[<C-w><C-k>]])
vim.keymap.set('n', '<leader>l', [[<C-w><C-l>]])

-- pane existence
vim.keymap.set('n', '<leader>s', vim.cmd.split)
vim.keymap.set('n', '<leader>v', vim.cmd.vsplit)
vim.keymap.set('n', '<leader>q', vim.cmd.q)
