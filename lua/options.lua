vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
-- auto session options recomneded by dev
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- line numbers
opt.relativenumber = true -- relative line numbers
opt.number = true -- absolute line number for current line

-- cursor types
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start

-- split windows
opt.splitright = false -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- clipboard
-- opt.clipboard="unnamed"
-- vim.opt.clipboard:append("unnamedplus")
opt.clipboard = "unnamedplus"
-- opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- turn off swapfile
opt.swapfile = false

-- true color support and appearance
opt.termguicolors = true
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- set line wrapping
opt.wrap = true -- endables wrapping
opt.linebreak = true --break at word boundries
opt.breakindent = true --indend breaks
opt.showbreak = "+++" --use an indicator for breaks

-- set folding
opt.foldmethod = "indent"
opt.foldcolumn = "1"
opt.foldenable = true
opt.foldlevelstart = 99
opt.foldminlines = 2

opt.spelllang = "en_us" -- spell for spell check use :set spell and :set nospell to turn on / off
opt.showmode = false -- handled by lualine: insert, visual, normal
opt.viminfo:append("h") -- prevent persistent searches
