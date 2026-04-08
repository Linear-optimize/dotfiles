vim.pack.add({

  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(e)
    if e.data.kind == "update" and e.data.name:find("treesitter") then
      vim.cmd("TSUpdate")
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      return
    end
    configs.setup({
      ensure_installed = {
        "python",
        "lua",
        "go",
        "rust",
        "vue",
        "javascript",
        "typescript",
        "html",
        "css",
        "json",
        "yaml",
        "toml",
        "markdown",
        "latex",
      },
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
          },
        },
      },
    })
  end,
})
