return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
        event = "VeryLazy",
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            local port = 13000
            local mason_path = vim.fn.stdpath("data") .. "/mason/"
            dap.adapters.codelldb = {
                type = "server",
                port = port,
                executable = {
                    -- CHANGE THIS to your path!
                    command = mason_path .. "bin/codelldb",
                    args = {"--port", port}

                    -- On windows you may have to uncomment this:
                    -- detached = false,
                }
            }
            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false
                }
            }

            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    }
}
