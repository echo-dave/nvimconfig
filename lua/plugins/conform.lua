return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		-- Define a custom Prettier formatter that uses .prettierrc if available
		local function custom_prettier_formatter(bufnr)
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			local config_files = vim.fs.find(".prettierrc", { upward = true, path = bufname })
			local config = config_files[1]
			local default = require("conform.formatters.prettier")

			if config then
				return {
					command = default.command,
					args = function()
						return { "--stdin-filepath", "$FILENAME", "--config", config }
					end,
					cwd = function()
						return vim.fs.dirname(config)
					end,
				}
			else
				return default
			end
		end

		-- Register the custom Prettier formatter
		-- conform.formatters.prettier = custom_prettier_formatter

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				-- python = { "isort", "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
			formatters = {
				stylua = {
					prepend_args = { "--quote-style", "AutoPreferDouble" },
				},
				prettier = custom_prettier_formatter,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
