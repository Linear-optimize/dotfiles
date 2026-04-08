vim.pack.add({
  { src = "https://github.com/Saghen/blink.cmp", version = "v1" },
})

vim.cmd("packadd blink.cmp")

require("blink.cmp").setup({

  keymap = {
    preset = "none",
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide" },

    ["<CR>"] = { "accept", "fallback" },

    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },

    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
  },

  completion = {
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },
    menu = {
      border = "rounded",
      draw = {
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = "rounded" },
    },

    ghost_text = { enabled = true },
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  signature = {
    enabled = true,
    window = { border = "rounded" },
  },
})
