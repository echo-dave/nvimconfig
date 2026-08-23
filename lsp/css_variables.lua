local blink_cmp = require("blink.cmp")
local capabilities = blink_cmp.get_lsp_capabilities({ include_nvim_defaults = true })
capabilities.textDocument.colorProvider = {
	dynamicRegistration = true,
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
return {
	cmd = { "css-variables-language-server", "--stdio" },
	filetypes = {
		"astro",
		"svelte",
		"vue",
		"vue-html",
		"vue-postcss",
		"scss",
		"postcss",
		"less",
		"css",
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"source.css.styled",
	},
	root_markers = { "package.json", ".git" },
	settings = {
		capabilities = capabilities,
		cssVariables = {
			suggestInNonCssFiles = false,
			blacklistFolders = {
				"**/.cache",
				"**/.DS_Store",
				"**/.git",
				"**/.hg",
				"**/.next",
				"**/.svn",
				"**/bower_components",
				"**/CVS",
				"**/dist",
				"**/node_modules",
				"**/tests",
				"**/tmp",
			},
			lookupFiles = { "**/*.less", "**/*.scss", "**/*.sass", "**/*.css" },
			-- lookupPrefix = "--",
		},
	},
}
