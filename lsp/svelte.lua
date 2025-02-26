return {
	cmd = { "svelteserver", "--stdio" },
	filetypes = { "svelte" },

	root_markers = { "svelte.config.js", "package.json", ".git" },
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.js", "*.ts" },
			callback = function(ctx)
				client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
			end,
		})
	end,
	settings = {
		svelte = {
			plugin = {
				diagnostics = { enable = true },
				html = { completions = { enable = true, emmet = true } },
				css = { completions = { enable = true, emmet = true } },
				typescript = {
					diagnostics = { enable = true },
					hover = { enable = true },
					completions = { enable = true },
				},
			},
		},
	},
}
