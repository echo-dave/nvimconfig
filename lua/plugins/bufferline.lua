return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	opts = {
		options = {
			mode = "buffers", --tabs as an option
			separator_style = "slant",
			-- name_formatter = function(buf)
			-- 	-- Extract the filename
			-- 	local filename = vim.fn.fnamemodify(buf.name, ":t")
			-- 	-- Extract the directory path with depth of 2
			-- 	local dir = vim.fn.fnamemodify(buf.name, ":h:h:t") .. "/" .. vim.fn.fnamemodify(buf.name, ":h:t")
			-- 	return dir .. "/" .. filename
			-- end,
		},
	},
}
