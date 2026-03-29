return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          if vim.fn.has("win32") == 1 then
            require("dap-python").setup(
              vim.fn.stdpath("data") .. "\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe"
            )
          else
            require("dap-python").setup("debugpy-adapter")
          end
        end,
      },
    },
  },
}