vim.pack.add({
        -- Markdown 渲染
        "https://github.com/MeanderingProgrammer/render-markdown.nvim",

        "https://github.com/chomosuke/typst-preview.nvim",
})

require("render-markdown").setup({
        file_types = { "markdown" },
})

require("typst-preview").setup({
  open_cmd = " start %s", -- Windows 改成 "start" 或 "open"(macOS)
})