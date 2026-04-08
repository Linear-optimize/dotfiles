vim.pack.add({

  "https://github.com/MeanderingProgrammer/render-markdown.nvim",

  "https://github.com/chomosuke/typst-preview.nvim",
})

require("render-markdown").setup({
  file_types = { "markdown" },
})

require("typst-preview").setup({
  open_cmd = " start %s",
})
