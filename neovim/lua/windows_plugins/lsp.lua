if vim.g.my_lsp_config_loaded then return end
vim.g.my_lsp_config_loaded = true

vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

-- 2. 自动下载与安装
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        local ok_mason, mason = pcall(require, "mason")
        if not ok_mason then return end

        mason.setup({ ui = { border = "rounded" } })
        require("mason-tool-installer").setup({
            ensure_installed = {
                "pyright", "ruff", "lua-language-server", "gopls", "rust-analyzer",
                "vue-language-server", "debugpy", "typescript-language-server",
                "delve", "codelldb", "stylua", "prettier",
            },
            run_on_start = true,
        })
        require("mason-lspconfig").setup()
    end,
})


local ok_blink, blink = pcall(require, "blink.cmp")
local capabilities = ok_blink and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

-- 4. 各语言详细配置
-- Lua
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
        },
    },
})

-- Python (Ruff)
vim.lsp.config("pyright", {
    capabilities = capabilities,
    settings = { python = { analysis = { typeCheckingMode = "standard" } } },
})

-- Rust
vim.lsp.config("rust_analyzer", {
    capabilities = capabilities,
    settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } },
})

-- Vue (Volar)
vim.lsp.config("volar", {
    capabilities = capabilities,
    filetypes = { "vue" },
    init_options = {
        vue = { hybridMode = true },
    },
})

-- TS_LS (TypeScript + Vue 插件)
vim.lsp.config("ts_ls", {
    capabilities = capabilities,
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                -- 修正：确保路径在 Windows 下被正确识别
                location = vim.fn.expand("$LOCALAPPDATA/nvim-data/mason/packages/vue-language-server/node_modules/@vue/language-server"),
                languages = { "vue" },
            },
        },
    },
})



-- 统一开启
vim.lsp.enable({ "lua_ls", "pyright", "gopls", "rust_analyzer", "ts_ls", "volar" })

-- 5. 诊断样式
vim.diagnostic.config({
    virtual_text = { spacing = 4, prefix = "●" },
    signs = true,
    underline = true,
    float = { source = true, border = "rounded" },
})

-- 6. 快捷键与自动命令
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
        map("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")
        map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        map("]d", vim.diagnostic.goto_next, "Next diagnostic")
    end,
})