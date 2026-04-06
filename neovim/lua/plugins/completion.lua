vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp", version = "v1" },
})

vim.cmd("packadd blink.cmp")

require("blink.cmp").setup({
	-- 1. 核心快捷键：解决回车不自动导入的问题
	keymap = {
		preset = "none", -- 禁用预设，手动定义以确保最符合你的习惯
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide" },
		-- 这里的 'accept' 是关键，它会告诉 LSP 执行自动导入
		["<CR>"] = { "accept", "fallback" },

		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },

		-- 如果你想用上下方向键选
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
	},

	-- 2. 补全行为优化
	completion = {
		-- 自动显示补全列表
		list = {
			selection = {
				preselect = true, -- 默认选中第一项，这样直接敲回车就能导
				auto_insert = false,
			},
		},
		-- 菜单样式
		menu = {
			border = "rounded",
			draw = {
				columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
			},
		},
		-- 自动显示文档（帮你确认是不是要导入的那个包）
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "rounded" },
		},
		-- 自动插入括号（比如输入函数后自动加 ()）
		ghost_text = { enabled = true },
	},

	-- 3. 基础外观
	appearance = {
		nerd_font_variant = "mono",
	},

	-- 4. 补全源
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},

	-- 5. 函数签名提示（打字时看到参数提示）
	signature = {
		enabled = true,
		window = { border = "rounded" },
	},
})
