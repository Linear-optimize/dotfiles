return {
  'chomosuke/typst-preview.nvim',
  lazy = false,
  version = '1.*',
  build = function()
    require('typst-preview').update()
  end,
  opts = {
    dependencies_bin = {
      ['tinymist'] = vim.fn.stdpath('data') .. '\\mason\\bin\\tinymist.cmd',
    },
  },
}