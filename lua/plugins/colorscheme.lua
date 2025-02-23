return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,

		config = function()
			-- local mocha = require("catppuccin.palettes").get_palette "mocha"

			require("catppuccin").setup({
				flavor = "mocha", --sets default
				background = {
					light = "latte",
					dark = "mocha",
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					blink_cmp = true,
				},
			})

			vim.cmd.colorscheme("catppuccin")

			-- vim.cmd([[colorscheme "catppuccin"]])
		end,
	},
}
