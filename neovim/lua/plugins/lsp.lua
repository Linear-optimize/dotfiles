local base_path = vim.fn.expand("$HOME/.bun/install/global/node_modules")
local vue_plugin_path = base_path .. "/@vue/language-server/node_modules/@vue/typescript-plugin"

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
				"vue-language-server", -- 补上 volar
				"debugpy",
				"clangd",
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

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
		},
	},
})

vim.lsp.config("pyright", {
	settings = {
		python = { analysis = { typeCheckingMode = "standard" } },
	},
})

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = { checkOnSave = { command = "clippy" } },
	},
})

vim.lsp.config("ts_ls", {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = vue_plugin_path,
				languages = { "vue" },
			},
		},
	},
	filetypes = {
		"typescript",
		"javascript",
		"javascriptreact",
		"typescriptreact",
		"vue",
	},
})

vim.lsp.config("volar", {
	filetypes = { "vue" },
	init_options = { vue = { hybridMode = true } },
})

vim.lsp.enable({
	"lua_ls",
	"pyright",
	"ruff",
	"gopls",
	"rust_analyzer",
	"ts_ls",
	"volar",
	"clangd",
})

vim.diagnostic.config({
	virtual_text = {
		spacing = 4,
		prefix = "●",
		format = function(diagnostic)
			return diagnostic.message
		end,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	float = {
		source = true,
		border = "rounded",
	},
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