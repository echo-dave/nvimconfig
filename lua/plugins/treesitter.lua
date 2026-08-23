return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",

		config = function()
			local treesitter = require("nvim-treesitter")

			treesitter.setup()

			local languages = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"scss",
				--"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				--"graphql",
				"bash",
				"lua",
				"vim",
				--"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				--"c",
				"bash",
				-- "python",
				-- "rust",
				"toml",
				"yaml",
			}

			treesitter.install(languages)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,

				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
}
