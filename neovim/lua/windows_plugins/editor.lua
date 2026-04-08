vim.opt.number = true
vim.opt.relativenumber = true
vim.pack.add({

  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/folke/which-key.nvim",
})

vim.pack.add({
  {
    src = "https://github.com/windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    src = "https://github.com/numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
})

require("gitsigns").setup()
require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_format" },
    lua = { "stylua" },
    go = { "gofmt" },
    rust = { "rustfmt" },
    vue = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
  },
  format_on_save = { timeout_ms = 500, lsp_fallback = true },
})

require("lualine").setup({
  options = {
    theme = "auto",
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

require("bufferline").setup({
  options = {
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    indicator = { style = "icon", icon = "▎" },
    buffer_close_icon = "󰅖",
    modified_icon = "●",
    close_icon = "",
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    diagnostics = "nvim_lsp",
  },
})

require("which-key").setup()
