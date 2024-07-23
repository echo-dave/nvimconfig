require("options")
require("keymap-custom")
require("lazy_manager")
require("theme")

-- from github discussion: https://github.com/neovim/neovim/discussions/28010#discussioncomment-9877494
local function paste()
	return {
		vim.fn.split(vim.fn.getreg(""), "\n"),
		vim.fn.getregtype(""),
	}
end

vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = paste,
		["*"] = paste,
	},
	-- paste = {
	--   ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
	--   ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
	-- },
}
vim.g.clipboard_max_length = 1000000

-- disable not installed providers to clear warnings
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
-- vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
