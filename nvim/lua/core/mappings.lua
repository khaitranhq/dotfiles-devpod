-- n, v, i, t = mode names

local M = {}

M.general = {
    n = {
        -- switch between windows
        ["<C-h>"] = {"<C-w>h", "Window left"},
        ["<C-l>"] = {"<C-w>l", "Window right"},
        ["<C-j>"] = {"<C-w>j", "Window down"},
        ["<C-k>"] = {"<C-w>k", "Window up"},
        -- quit
        ["qq"] = {"<cmd>qa<CR>", "Quit Neovim"},
        -- short key to run commands
        [";"] = {":", "Short key to run commands"},
        ["<leader>pwd"] = {
            function()
                print("Current directory: " .. vim.api.nvim_buf_get_name(0))
            end,
            "Show directory of current buffer"
        },
        ["<leader>/"] = {"<cmd>nohlsearch<CR>", "Disable search highlight"},
        ["p"] = {'"+p', "Paste"}
    },
    v = {
        ["//"] = {'y/\\V<C-R>=escape(@",\'/\')<CR><CR>', "Search with selected text"},
        ["y"] = {'"+y', "Yank"},
        ["d"] = {'"+d', "Cut"},
        ["x"] = {'"+x', "Cut single character"}
    }
}

M.nvimtree = {
    n = {
        ["<leader>b"] = {"<cmd>NvimTreeToggle<CR>", "Toggle nvim tree"},
        ["<leader>cbv"] = {vim.nvim_tree_change_view_type, "Toggle nvim tree"}
    }
}

local telescope_builtin = require("telescope.builtin")
M.telescope = {
    n = {
        ["<leader>ff"] = {telescope_builtin.find_files, "Find files"},
        ["<leader>fg"] = {telescope_builtin.live_grep, "Search text globally"},
        ["<leader>fb"] = {telescope_builtin.buffers, "Search buffers"},
        ["<leader>fc"] = {telescope_builtin.current_buffer_fuzzy_find, "Search text in current buffer"}
    },
    v = {
        ["<leader>fs"] = {vim.search_with_selected_text, "Search with selected text"}
    }
}

M.lsp = {
    n = {
        ["<leader>dr"] = {vim.lsp.buf.rename, "Rename variable at cursor"},
        ["<leader>dp"] = {vim.diagnostic.goto_prev, "Previous diagnostic position"},
        ["<leader>dn"] = {vim.diagnostic.goto_next, "Next diagnostic position"},
        ["<leader>de"] = {vim.diagnostic.open_float, "Show diagnostic message in a float window"},
        ["<leader>dfd"] = {vim.lsp.buf.hover, "Show document in float window"},
        ["<leader>dd"] = {vim.lsp.buf.definition, "Show definition"},
        ["<leader>dfe"] = {"<cmd>Lspsaga peek_definition<CR>", "Peek definition"},
        ["<leader>dci"] = {"<cmd>Lspsaga incoming_calls<CR>", "Incoming call"},
        ["<leader>dco"] = {"<cmd>Lspsaga outgoing_calls<CR>", "Outgoing call"},
        ["<leader>dca"] = {"<cmd>Lspsaga code_action<CR>", "Call action"},
        ["<leader>dcm"] = {"<cmd>Lspsaga finder imp<CR>", "Search and preview implementation"}
    }
}

local notify = require("notify")
M.notify = {
    n = {
        ["<leader>nh"] = {notify.dismiss, "Dismiss all notifications"}
    }
}

M.git = {
    n = {
        ["<leader>gs"] = {"<cmd>Git<CR>", "Open Git"},
        ["<leader>gb"] = {"<cmd>Git blame<CR>", "Git blame"},
        ["<leader>gd"] = {"<cmd>Gdiffsplit<CR>", "Git diff split"},
        ["<leader>gl"] = {vim.term_lazygit_toggle, "Open lazygit"},
        ["<leader>gcm"] = {vim.term_aicommits_toggle, "Git commit with aicommits"},
        ["<leader>gcc"] = {"<cmd>GitConflictChooseOurs<CR>", "Git conflict: select current change"},
        ["<leader>gci"] = {"<cmd>GitConflictChooseTheirs<CR>", "Git conflict: select incomming change"},
        ["<leader>gcb"] = {"<cmd>GitConflictChooseBoth<CR>", "Git conflict: select both changes"},
        ["<leader>gcx"] = {"<cmd>GitConflictChooseNone<CR>", "Git conflict: select none of the changes"},
        ["<leader>gcn"] = {"<cmd>GitConflictNextConflict<CR>", "Git conflict: select next conflict"},
        ["<leader>gcp"] = {"<cmd>GitConflictPrevConflict<CR>", "Git conflict: select previous conflict"}
    }
}

M.format = {
    n = {
        ["<leader>fm"] = {vim.cmd.FormatWrite, "Format file"}
    }
}

M.window_picket = {
    n = {
        ["<leader>w"] = {vim.window_picker_select, "Pick window"}
    }
}

M.leap = {
    n = {
        ["s"] = {"<Plug>(leap)", "Navigate with leap"}
    }
}

M.dap = {
    n = {
        ["<leader>ss"] = {vim.cmd.DapContinue, "Run or continue"},
        ["<leader>sn"] = {vim.cmd.DapStepOver, "Step over"},
        ["<leader>st"] = {vim.cmd.DapTerminate, "Terminate debug session"},
        ["<leader>sb"] = {vim.cmd.DapToggleBreakpoint, "Toggle breakpoint"},
        ["<leader>sc"] = {require("dapui").close, "Close debug ui"}
    }
}

return M
