vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt

opt.number = true
opt.showcmd = false
opt.hidden = true
opt.expandtab = true
opt.softtabstop = 2
opt.shiftwidth = 2
opt.wrap = false
opt.cursorline = false
opt.ruler = false
opt.cmdheight = 1
opt.shortmess:append("c")
opt.termguicolors = true
opt.fillchars:append({ vert = "." })
opt.splitbelow = true
opt.showmode = false
opt.ignorecase = true
opt.smartcase = true
opt.autoread = true
opt.swapfile = false
opt.undofile = true
opt.undolevels = 3000
opt.undoreload = 10000
opt.backup = true
opt.backupdir = vim.fn.expand("~/.local/share/nvim/backup")

vim.fn.mkdir(vim.fn.expand("~/.local/share/nvim/backup"), "p")
