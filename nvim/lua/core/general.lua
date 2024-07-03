local opt = vim.opt

------------------------options------------------------
-- tab indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- show relative line number
opt.number = true
opt.relativenumber = true

-- Set clipboard
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}
-- opt.clipboard = "unnamed,unnamedplus"

-- set termguicolors to enable highlight groups
opt.termguicolors = true

-- set foldmethod
opt.foldmethod = "indent"
opt.foldlevel = 20

-- set undodir
UNDODIR = os.getenv( "HOME" ) .. "/.local/share/nvim/undo/"
if vim.fn.isdirectory(UNDODIR) == 0 then
	vim.fn.mkdir(UNDODIR, "p", "0o700")
end
vim.opt.undodir = UNDODIR
vim.opt.undofile = true

-- set spell check
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-------------------------global-------------------------
vim.g.mapleader = " "

vim.o.autoread = true
vim.api.nvim_create_autocmd(
    {"BufEnter", "CursorHold", "CursorHoldI", "FocusGained"},
    {
        command = "if mode() != 'c' | checktime | endif",
        pattern = {"*"}
    }
)
