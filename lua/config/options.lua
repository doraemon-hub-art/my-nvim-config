-- Vim options
local opt = vim.opt

-- General
opt.termguicolors = true
opt.mouse = "a"
opt.title = true
opt.clipboard = "unnamedplus"

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Cursor
opt.cursorline = true
opt.cursorcolumn = true
opt.virtualedit = "block"

-- Wrap
opt.wrap = false
opt.linebreak = true
opt.breakindent = true

-- Indent
opt.tabstop = 2
opt.shiftwidth = 0 -- 0 means use tabstop value
opt.expandtab = true
opt.shiftround = true
opt.copyindent = true
opt.preserveindent = true
opt.autoindent = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

-- Split
opt.splitright = true
opt.splitbelow = true

-- UI
opt.signcolumn = "yes"
opt.showmode = false
opt.showtabline = 2
opt.laststatus = 3 -- global statusline
opt.cmdheight = 0
opt.pumheight = 10
opt.spell = false
opt.background = "light"
opt.fillchars = { eob = " " }
opt.shortmess = vim.tbl_deep_extend("force", vim.opt.shortmess:get(), { s = true, I = true, c = true, C = true })

-- Editing
opt.backspace = vim.list_extend(vim.opt.backspace:get(), { "nostop" })
opt.confirm = true
opt.undofile = true
opt.writebackup = false
opt.completeopt = { "menu", "menuone", "noselect" }
opt.timeoutlen = 500
opt.updatetime = 300
opt.fixendofline = false
opt.diffopt = vim.list_extend(vim.opt.diffopt:get(), { "algorithm:histogram", "linematch:60" })
