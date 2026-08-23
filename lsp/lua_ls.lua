return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc" },
	settings = {
		Lua = {
			diagnostics = { globals = { "require", "vim" } },
			runtime = { version = "LuaJIT" },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				[vim.fn.stdpath("config") .. "/lua"] = true,
				[vim.fn.stdpath("data") .. "/lazy/blink.cmp/lua"] = true,
			},
			telemetry = { enable = false },
		},
	},
}
