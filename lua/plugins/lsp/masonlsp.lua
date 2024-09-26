return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		local lspconfig = require("lspconfig")

		-- lspconfig.html.setup({
		-- 	on_attach = function(client, bufnr)
		-- 		-- Enable completion triggered by <c-x><c-o>
		-- 		vim.api.nvim_set_option_value("filetype", "html", { buf = bufnr })
		-- 	end,
		-- })

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"tsserver",
				-- "html",
				-- "emmet_ls",
				"cssls",
				-- "tailwindcss",
				"svelte",
				"lua_ls",
			},
		})
		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				-- "isort", -- python formatter
				-- "black", -- python formatter
			},
		})
	end,
}
