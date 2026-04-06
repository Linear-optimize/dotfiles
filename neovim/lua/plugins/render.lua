vim.pack.add({
	-- Markdown 渲染
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",

	"https://github.com/lervag/vimtex",
})

require("render-markdown").setup({
	file_types = { "markdown" },
})