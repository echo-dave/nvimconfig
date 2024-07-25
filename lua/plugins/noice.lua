return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	config = function()
		require("notify").setup({
			max_width = 45,
		})
		local noice = require("noice")
		noice.setup({
			views = {
				-- 	-- mini = {
				-- 	-- 	timeout = 5000,
				-- 	-- 	close_events = { "CursorMoved", "CursorMovedI", "InsertEnter" },
				-- 	-- },
				-- 	NOTE: testing mini notifications due to notify truncating

				messages = {
					enabled = true, -- enables the Noice messages UI
					view = "notify", -- default view for messages
					view_error = "mini", -- view for errors
					view_warn = "mini", -- view for warnings
					view_history = "messages", -- view for :messages
					view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
				},
				-- WARN: notify clips longer messages
				notify = {
					backend = "notify",
					fallback = "mini",
					format = "notify",
					replace = false,
					merge = false,
					max_width = 45,
				},
				cmdline_popup = {
					position = {
						row = "35%",
						col = "50%",
					},
					size = {
						width = 60,
						height = "auto",
					},
				},
				cmdline_popupmenu = {
					relative = "editor",
					position = {
						row = "55%",
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
				popupmenu = {
					size = {
						width = 60,
						height = 6,
					},
				},
				hover = {
					border = {
						style = "rounded",
					},
					size = {
						width = 40,
						height = 10,
					},
					position = { row = 2, col = 2 },
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "change",
						max_height = 1,
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "lines?%s+changed",
						max_height = 1,
					},
					opts = { skip = true },
				},
				{
					filter = {
						event = "msg_show",
						kind = "",
						find = "written",
						max_height = 1,
					},
					opts = { skip = true },
				},
				{
					filter = { -- trying to capture long messages from commands like map / nmap that have no "kind"
						event = "msg_show",
						kind = { "" },
						min_height = 5,
					},
					view = "popup",
				},
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
		})
	end,
}
