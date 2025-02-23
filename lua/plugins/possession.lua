local function open_snacks_dashboard()
	require("snacks").dashboard()
end

return {
	"jedrzejboczar/possession.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("telescope").load_extension("possession")
		require("possession").setup({
			autoload = false, -- false or "auto_cwd" WARNING: auto_cwd will bug out on loading a session saved with no open files
			autosave = {
				current = false,
				cwd = false,
				tmp = false,
				tmp_name = "tmp",
				on_load = false,
				on_quit = true,
			},
			hooks = {
				before_save = function(name)
					return {}
				end,
				after_save = function(name, user_data, aborted) end,
				before_load = function(name, user_data)
					if vim.o.sessionoptions:match("buffer") then
						-- Close all buffers from the outgoing session
						local buflist = vim.api.nvim_list_bufs()
						for _, bufnr in ipairs(buflist) do
							if vim.fn.buflisted(bufnr) == 1 then
								vim.cmd("bd " .. bufnr)
							end
						end
					end
					return user_data
				end,
				after_load = function(name, user_data)
					vim.defer_fn(open_snacks_dashboard, 1000)
				end,
			},
			plugins = {
				close_windows = {
					hooks = { "before_save", "before_load" },
					preserve_layout = true, -- or fun(win): boolean
					match = {
						floating = true,
						buftype = {},
						filetype = { "NvimTree", "Trouble", "nofile" },
						custom = false, -- or fun(win): boolean
					},
				},
				delete_hidden_buffers = {
					hooks = {
						"before_load",
					},
					force = true, -- or fun(buf): boolean
				},
				nvim_tree = true,
				neo_tree = true,
				symbols_outline = true,
				outline = true,
				tabby = true,
				dap = true,
				dapui = true,
				neotest = true,
				delete_buffers = false,
				stop_lsp_clients = false,
			},
		})
	end,
	keymap = {
		vim.keymap.set(
			"n",
			"<leader>ps",
			"<cmd>PossessionSaveCwd<cr>",
			{ noremap = true, silent = true, desc = "Possession Save" }
		),
		vim.keymap.set("n", "<leader>fws", function()
			require("telescope").extensions.possession.list({
				initial_mode = "normal", -- Set initial mode to normal
			})
		end, { noremap = true, silent = true, desc = "Possession List" }),
	},
}
