vim.pack.add({
  "https://github.com/nvimdev/dashboard-nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/catppuccin/nvim",
})

require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    treesitter = true,
    native_lsp = { enabled = true },
    dashboard = true,
    snacks = true,
    gitsigns = true,
    mason = true,
    dap = { enabled = true, enable_ui = true },
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin")
-- Snacks
require("snacks").setup({
  picker = { enabled = true },
  notifier = { enabled = true },
  zen = { enabled = false },

  image = { enabled = true },
  lazygit = { enabled = true },
  indent = { enabled = true },
  words = { enabled = true },
})

local logo = [[
    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠂⠀⢠⠀⢀⡞⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢰⢀⠀⠀⠀⣰⡇⠀⡆⡄⢠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⠀⠀⠀⠀⠀
⠀⠀⠀⢸⢸⡆⠀⢴⢷⡧⣼⣇⣀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣧⠀⠀⠀⠀⠀
⠀⠀⠀⢸⣿⣇⠀⢹⠀⢧⠀⣧⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢹⠀⠀⠀⠀⠀
⠀⠀⠀⢸⠉⢻⣦⣾⣶⣾⣌⠛⣌⢸⠀⠀⠀⠀⡐⠀⠀⠀⣠⢿⢸⠀⠀⠀⠀⠀
⡀⠀⠀⢸⢰⡿⢻⣼⣿⣦⢱⠁⠉⠸⠀⡀⢠⡞⠁⠀⢀⡜⠉⣾⣾⢀⣴⠀⠀⠀
⠀⠉⠉⢸⡀⠇⡟⣿⣿⢏⠏⠃⢰⠷⢻⠗⠋⢀⡠⡲⢟⡚⠲⠻⢑⢟⣿⠀⡄⠀
⠀⠀⠀⠘⠁⠀⠸⠦⠄⠊⠀⠀⠀⠈⠉⠛⠋⠉⣷⣟⣿⣛⢻⢫⣁⣾⢇⣼⠃⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢱⢿⣿⣿⢠⠡⡟⠵⡏⡘⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠸⡘⢛⡡⠃⣠⢧⡾⠐⠕⡱⡠
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠂⠀⠀⠀⠈⠈⠀⠀⢈⡴⣩⣴⡤⡞⡻⠓
⠀⠀⠀⢠⠀⠀⠀⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠋⡝⠀⡧⠁⠀
⠀⠀⠀⢸⣧⡀⠀⠀⠀⠩⣐⠂⠤⢀⠀⠀⠀⠀⠀⠀⠀⢀⠔⠁⢀⠧⠚⠁⠀⠀
⠀⠀⠀⣸⣿⡷⣄⠀⠀⠀⠈⠉⠁⠀⠀⠀⠀⠀⠀⢀⢴⢃⠠⠊⢹⠀⢠⡆⠀⠀
⠀⡠⠊⢸⣿⡇⠈⢢⡀⠀⠀⠀⠀⣀⡀⡤⠔⡖⠈⠁⡸⡘⠀⠀⡄⠀⢸⠁⠀⠀
⠁⠀⠀⢸⣿⡇⠀⠀⠹⠶⠿⠟⠋⢁⠜⠣⡀⡇⠀⠀⣿⠁⠀⢠⠀⠀⠿⠀⠀⠀
⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⢠⠎⠀⠀⠈⠲⡀⠀⡟⠀⠀⡌⠀⠀⡆⠀⠀⠀
⠀⠀⠀⢸⣿⣷⠀⠀⠀⠀⣀⡴⠃⠀⠀⠀⠀⠀⠙⣾⡇⠀⠀⠁⠀⢸⠁⠀⠀⡀
]]

local center = {
  {
    action = function()
      Snacks.picker.files()
    end,
    desc = " Find File",
    icon = " ",
    key = "f",
  },
  {
    action = "ene | startinsert",
    desc = " New File",
    icon = " ",
    key = "n",
  },
  {
    action = function()
      Snacks.picker.recent()
    end,
    desc = " Recent Files",
    icon = " ",
    key = "r",
  },
  {
    action = function()
      Snacks.picker.grep()
    end,
    desc = " Find Text",
    icon = " ",
    key = "g",
  },
  {
    action = function()
      Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
    end,
    desc = " Config",
    icon = " ",
    key = "c",
  },
  {
    action = function()
      vim.api.nvim_input("<cmd>qa<cr>")
    end,
    desc = " Quit",
    icon = " ",
    key = "q",
  },
}

for _, btn in ipairs(center) do
  btn.desc = btn.desc .. string.rep(" ", 43 - #btn.desc)
  btn.key_format = "  %s"
end

require("dashboard").setup({
  theme = "doom",
  hide = { statusline = false },
  config = {
    header = vim.split(string.rep("\n", 8) .. logo .. "\n\n", "\n"),
    center = center,
    footer = function()
      return { "⚡ Neovim ready" }
    end,
  },
})
