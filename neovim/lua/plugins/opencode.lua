return {
  "nickjvandyke/opencode.nvim",

  version = "*",
  config = function()
    local opencode = require("opencode")

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
  end,
}
