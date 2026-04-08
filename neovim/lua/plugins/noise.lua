vim.pack.add({
  "https://github.com/folke/noice.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
})

require("noice").setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
  },
  popupmenu = {
    enabled = true,
  },
  messages = {
    enabled = true,
  },
  notify = {
    enabled = true,
  },
  views = {
    cmdline_popup = {
      position = {
        row = "10%",
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
  },

  routes = {
    {
      filter = {
        event = "lsp",
        kind = "progress",
        cond = function(message)
          local client = vim.tbl_get(message.opts, "progress", "client")
          return client == "pyright"
        end,
      },
      opts = { skip = true },
    },
  },
})
