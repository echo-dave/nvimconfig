vim.filetype.add({
	filename = {
		[".zshrc"] = "zsh",
		[".zshenv"] = "zsh",
		[".zprofile"] = "zsh",
		[".zlogin"] = "zsh",
		[".zlogout"] = "zsh",
		["p10k.zsh"] = "zsh",

		[".bashrc"] = "bash",
		[".bash_profile"] = "bash",
		[".bash_login"] = "bash",
		[".bash_logout"] = "bash",

		[".profile"] = "sh",
		["tmux.conf"] = "tmux",
	},
})
