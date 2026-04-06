vim.pack.add({
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/mfussenegger/nvim-dap-python", -- 必须加这个插件
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/theHamsta/nvim-dap-virtual-text",
    "https://github.com/jay-babu/mason-nvim-dap.nvim",
})

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        local ok, dap = pcall(require, "dap")
        if not ok then return end

        local dapui = require("dapui")

        -- 1. 基础 setup
        require("mason-nvim-dap").setup({
            ensure_installed = { "debugpy", "delve", "codelldb" },
            automatic_installation = true,
            handlers = {}, -- 这里保持为空，让后面手动 setup 接管
        })


        local dap_python = require("dap-python")
        if vim.fn.has("win32") == 1 then

            local debugpy_python = vim.fn.stdpath("data") .. [[\mason\packages\debugpy\venv\Scripts\python.exe]]
            dap_python.setup(debugpy_python)
        else
            dap_python.setup("debugpy-adapter")
        end

        -- 3. 其他保持原样
        dapui.setup()
        require("nvim-dap-virtual-text").setup()


        vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
        vim.fn.sign_define("DapBreakpointCondition", { text = "◐", texthl = "DapBreakpointCondition" })
        vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected" })

        -- 自动开关 UI (保持原样)
        dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui"] = function() dapui.close() end

        -- Keymaps (保持原样)
        local m = vim.keymap.set
        m("n", "<F5>", dap.continue, { desc = "DAP Continue" })
        m("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
        m("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
        m("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
        m("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
        m("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
        m("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
    end,
})
