vim.pack.add({
    "https://github.com/nvim-neo-tree/neo-tree.nvim",
    "https://github.com/nvim-lua/plenary.nvim",        -- 依赖
    "https://github.com/nvim-tree/nvim-web-devicons",  -- 图标
    "https://github.com/MunifTanjim/nui.nvim",         -- UI 组件
})

require("neo-tree").setup({
    close_if_last_window = true,   -- 最后一个窗口时自动关闭
    window = {
        position = "left",
        width = 30,
    },
    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = false,   -- 显示 .config 这类隐藏文件
            hide_gitignored = true,
        },
        follow_current_file = {
            enabled = true,          -- 自动定位当前文件
        },
    },
    default_component_configs = {
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
        },
    },
})

-- 快捷键
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus<cr>",  { desc = "Focus Neo-tree" })