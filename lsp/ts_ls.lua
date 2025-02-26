return {
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
		"typescript.tsx",
		"javascript.jsx",
	},
	settings = {
		completion = {
			completeFunctionCalls = true,
		},
	},
	root_markers = { "tsconfig.json", "package.json", ".git" },
	init_options = {
		hostInfo = "neovim",
	},
}
