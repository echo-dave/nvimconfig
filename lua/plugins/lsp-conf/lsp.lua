local mason_bin_path = vim.fn.stdpath("data") .. "/mason/bin/"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = {
		"documentation",
		"detail",
		"additionalTextEdits",
	},
}
capabilities.textDocument.semanticTokens.multilineTokenSupport = true

return {
	vim.lsp.config("*", {
		capabilities = capabilities,
		root_markers = { ".git" },
		cmd_env = {
			PATH = mason_bin_path .. ":" .. vim.env.PATH,
		},
		vim.lsp.set_log_level("warn"),
		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "󰋼",
					[vim.diagnostic.severity.HINT] = "󰠠",
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = false,
		}),
	}),
	vim.lsp.enable({
		"lua_ls",
		"svelte",
		"ts_ls",
		-- "emmet_ls",
		"tailwind",
		"css_variables",
		"html",
		"css",
		-- "emmet_vscode",
	}),
}
