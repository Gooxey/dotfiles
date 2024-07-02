vim.keymap.set("n", "<leader>pv", function() vim.cmd([[Oil --float]]) end)

require("oil").setup({
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,

    keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<Space>"] = "actions.select",
        ["q"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
    },
    use_default_keymaps = false,

    view_options = {
        show_hidden = true,
    },

    git = {
        -- Return true to automatically git add/mv/rm files
        add = function(path)
            return true
        end,
        mv = function(src_path, dest_path)
            return true
        end,
        rm = function(path)
            return true
        end,
    },

    float = {
        padding = 8,
        max_width = 128,
    },
})
