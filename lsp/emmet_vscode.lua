return {
	cmd = { "emmet-language-server", "--stdio" },
	filestypes = {
		{
			"css",
			"eruby",
			"html",
			"htmldjango",
			"javascriptreact",
			"less",
			"pug",
			"sass",
			"scss",
			"typescriptreact",
			"htmlangular",
		},
		root_markers = { "package.json", ".git" },
		single_file_support = true,
	},
}
