vim.filetype.add({
	filename = {
		[".zshrc"] = "sh",
		[".bashrc"] = "sh",
		[".bash_profile"] = "sh",
		[".profile"] = "sh",
		[".zshenv"] = "sh",
		[".zprofile"] = "sh",
		["tmux.conf"] = "sh",
		["p10k.zsh"] = "sh",
	},
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"html",
		"css",
		"scss",
		"json",
		"yaml",
		"svelte",
		"python",
		"javascript",
		"typescript",
		"typescriptreact",
		"tsx",
		"bash",
		"gitignore",
		"query",
		"vimdoc",
		"toml",
		"rust",
		"go",
		"c",
		"c++",
	},
	callback = function()
		vim.treesitter.start()
	end,
})
