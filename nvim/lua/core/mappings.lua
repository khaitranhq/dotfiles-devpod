-- n, v, i, t = mode names

local M = {}

M.general = {
	n = {
		-- switch between windows
		["<C-h>"] = { "<C-w>h", "Window left" },
		["<C-l>"] = { "<C-w>l", "Window right" },
		["<C-j>"] = { "<C-w>j", "Window down" },
		["<C-k>"] = { "<C-w>k", "Window up" },
		-- quit
		["qq"] = { "<cmd>qa<CR>", "Quit Neovim" },
		-- short key to run commands
		[";"] = { ":", "Short key to run commands" },
		["<leader>pwd"] = {
			function()
				print("Current directory: " .. vim.api.nvim_buf_get_name(0))
			end,
			"Show directory of current buffer",
		},
		["<leader>/"] = { "<cmd>nohlsearch<CR>", "Disable search highlight" },
		["p"] = { '"+p', "Paste" },
		["<leader>tt"] = { "<cmd>tabnew<CR>", "New tab" },
		["<leader>tn"] = { "<cmd>+tabnext<CR>", "Next tab" },
		["<leader>tp"] = { "<cmd>-tabnext<CR>", "Previous tab" },
		["<leader>tx"] = { "<cmd>tabclose<CR>", "Close tab" },
	},
	v = {
		["//"] = { "y/\\V<C-R>=escape(@\",'/')<CR><CR>", "Search with selected text" },
		["y"] = { '"+y', "Yank" },
		["d"] = { '"+d', "Cut" },
		["x"] = { '"+x', "Cut single character" },
	},
}

M.nvimtree = {
	n = {
		["<leader>b"] = { "<cmd>NvimTreeToggle<CR>", "Toggle nvim tree" },
		["<leader>cbv"] = { vim.nvim_tree_change_view_type, "Toggle nvim tree" },
	},
}

local fzf = require("fzf-lua")
M.fzf = {
	n = {
		["<leader>ff"] = { fzf.files, "Find files" },
		["<leader>fg"] = { fzf.live_grep, "Search text globally" },
		["<leader>fb"] = { fzf.buffers, "Search buffers" },
		["<leader>ft"] = { fzf.tabs, "Browse tabs" },
	},
	v = {
		["<leader>fs"] = { fzf.grep_visual, "Search with selected text" },
	},
}

M.lsp = {
	n = {
		["<leader>dr"] = { vim.lsp.buf.rename, "Rename variable at cursor" },
		["<leader>dp"] = { vim.diagnostic.goto_prev, "Previous diagnostic position" },
		["<leader>dn"] = { vim.diagnostic.goto_next, "Next diagnostic position" },
		["<leader>de"] = { vim.diagnostic.open_float, "Show diagnostic message in a float window" },
		["<leader>dfd"] = { vim.lsp.buf.hover, "Show document in float window" },
		["<leader>dd"] = { vim.lsp.buf.definition, "Show definition" },
		["<leader>dfe"] = { fzf.lsp_definitions, "Peek definition" },
		["<leader>dci"] = { fzf.lsp_incoming_calls, "Incoming call" },
		["<leader>dco"] = { fzf.lsp_outgoing_calls, "Outgoing call" },
		["<leader>dcm"] = { fzf.lsp_implementations, "Search and preview implementation" },
		["<leader>dca"] = { fzf.lsp_code_actions, "Code action" },
	},
}

local notify = require("notify")
M.notify = {
	n = {
		["<leader>nh"] = { notify.dismiss, "Dismiss all notifications" },
	},
}

M.git = {
	n = {
		["<leader>gb"] = { vim.term_git_branch, "Git branch" },
		["<leader>gl"] = { vim.term_lazygit_toggle, "Open lazygit" },
		["<leader>gcm"] = { vim.term_aicommits_toggle, "Git commit with aicommits" },
		["<leader>gcc"] = { "<cmd>GitConflictChooseOurs<CR>", "Git conflict: select current change" },
		["<leader>gci"] = { "<cmd>GitConflictChooseTheirs<CR>", "Git conflict: select incomming change" },
		["<leader>gcb"] = { "<cmd>GitConflictChooseBoth<CR>", "Git conflict: select both changes" },
		["<leader>gcx"] = { "<cmd>GitConflictChooseNone<CR>", "Git conflict: select none of the changes" },
		["<leader>gcn"] = { "<cmd>GitConflictNextConflict<CR>", "Git conflict: select next conflict" },
		["<leader>gcp"] = { "<cmd>GitConflictPrevConflict<CR>", "Git conflict: select previous conflict" },
	},
}

M.format = {
	n = {
		["<leader>fm"] = { vim.cmd.FormatWrite, "Format file" },
	},
}

M.window_picket = {
	n = {
		["<leader>w"] = { vim.window_picker_select, "Pick window" },
	},
}

M.leap = {
	n = {
		["s"] = { "<Plug>(leap)", "Navigate with leap" },
	},
}

return M
