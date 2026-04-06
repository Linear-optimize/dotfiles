-- init.lua 或 plugins.lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.pack.add({
	-- AI
	"https://github.com/nickjvandyke/opencode.nvim",
	-- autopairs
	"https://github.com/windwp/nvim-autopairs",
	-- 注释
	"https://github.com/numToStr/Comment.nvim",
	-- Git signs
	"https://github.com/lewis6991/gitsigns.nvim",
	-- 格式化
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
})

-- 基础插件 setup
require("nvim-autopairs").setup()
require("Comment").setup() -- ⚠️ 注意：模块名是 "Comment" 不是 "Comment.nvim"
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

-- OpenCode setup
local ok, opencode = pcall(require, "opencode")
if ok then
	vim.o.autoread = true
	vim.keymap.set("n", "<leader>oa", function()
		opencode.ask("@buffer: ", { submit = true })
	end, { desc = "OpenCode: Send full buffer" })
	vim.keymap.set("x", "<leader>oa", function()
		opencode.ask("@this: ", { submit = true })
	end, { desc = "OpenCode: Ask selection" })
	vim.keymap.set({ "n", "t" }, "<C-.>", function()
		opencode.toggle()
	end, { desc = "Toggle OpenCode Window" })
end