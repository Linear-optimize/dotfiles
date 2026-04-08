if vim.g.my_lsp_config_loaded then
  return
end
vim.g.my_lsp_config_loaded = true

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local ok_mason, mason = pcall(require, "mason")
    if not ok_mason then
      return
    end

    mason.setup({ ui = { border = "rounded" } })
    require("mason-tool-installer").setup({
      ensure_installed = {
        "pyright",
        "ruff",
        "lua-language-server",
        "gopls",
        "rust-analyzer",
        "vue-language-server",
        "debugpy",
        "typescript-language-server",
        "delve",
        "codelldb",
        "stylua",
        "prettier",
      },
      run_on_start = true,
    })
    require("mason-lspconfig").setup()
  end,
})

local ok_blink, blink = pcall(require, "blink.cmp")
local capabilities = ok_blink and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
    },
  },
})

vim.lsp.config("pyright", {
  capabilities = capabilities,
  settings = { python = { analysis = { typeCheckingMode = "standard" } } },
})

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
  settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } },
})

vim.lsp.config("volar", {
  capabilities = capabilities,
  filetypes = { "vue" },
  init_options = {
    vue = { hybridMode = true },
  },
})

vim.lsp.config("ts_ls", {
  capabilities = capabilities,
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",

        location = vim.fn.expand(
          "$LOCALAPPDATA/nvim-data/mason/packages/vue-language-server/node_modules/@vue/language-server"
        ),
        languages = { "vue" },
      },
    },
  },
})

vim.lsp.enable({ "lua_ls", "pyright", "gopls", "rust_analyzer", "ts_ls", "volar" })

vim.diagnostic.config({
  virtual_text = { spacing = 4, prefix = "●" },
  signs = true,
  underline = true,
  float = { source = true, border = "rounded" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(e)
    local map = function(k, f, desc)
      vim.keymap.set("n", k, f, { buffer = e.buf, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gr", vim.lsp.buf.references, "References")
    map("K", vim.lsp.buf.hover, "Hover docs")
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "Format")
    map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
    map("]d", vim.diagnostic.goto_next, "Next diagnostic")
  end,
})
