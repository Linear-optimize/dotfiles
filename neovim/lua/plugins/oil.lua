vim.pack.add({
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/MunifTanjim/nui.nvim",
})

require("neo-tree").setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,

  window = {
    position = "left",
    width = 30,
    mappings = {
      ["<space>"] = "none",
    },
  },

  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      padding = 1,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "󰜌",
      default = "󰈚",
    },
    modified = {
      symbol = "●",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
    },
    git_status = {
      symbols = {
        added = "",
        modified = "",
        deleted = "✖",
        renamed = "󰁕",
        untracked = "",
        ignored = "",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
      },
    },
  },

  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
    },
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
  },

  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function()
        vim.opt_local.signcolumn = "no"
        vim.opt_local.statuscolumn = ""
      end,
    },
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Focus Neo-tree" })
