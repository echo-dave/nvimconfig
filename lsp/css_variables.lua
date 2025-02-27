return {
	cmd = { "css-variables-language-server", "--stdio" },
	filetypes = { "css", "scss", "less", "svelte", "vue" },
	root_markers = { "package.json", ".git" },
	settings = {
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
			lookupPrefix = "--",
		},
	},
}
