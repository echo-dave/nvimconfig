local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
return {
	capabilities = capabilities,
	init_options = {
		html = {
			options = {
				--https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["ben.enabled"] = true,
				["jsx.enabled"] = true,
				["comment.enabled"] = true, --Enable/disable element commenting: generate comments before open and/or after close tag
			},
		},
	},
	cmd = { "emmet-ls", "--stdio" },
	filetypes = {
		"html",
		"typescriptreact",
		"javascriptreact",
		"css",
		"sass",
		"scss",
		"less",
		"svelte",
		"vue",
	},
}
