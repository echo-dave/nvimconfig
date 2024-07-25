return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"rmagatti/auto-session",
		-- "JoseConseco/telescope_sessions_picker.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local autoSessionLensActions = require("auto-session.session-lens.actions")

		local function wrapped_delete_session(prompt_bufnr)
			print("Selected session deleted")
			autoSessionLensActions.delete_session(prompt_bufnr)
		end
		-- NOTE: this seems to be bugged at the source
		--
		-- local function wrapped_alternate_session(prompt_bufnr)
		-- 	print("Alt session toggled")
		-- 	autoSessionLensActions.alternate_session(prompt_bufnr) -- doesn't seem to work
		-- end

		telescope.setup({
			pickers = {
				buffers = {
					mappings = {
						n = {
							["dd"] = actions.delete_buffer, -- close buffers
						},
						i = {
							["<C-d>"] = actions.delete_buffer, -- close buffers
						},
					},
				},
			},
			defaults = {
				initial_mode = "insert",
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
					n = {
						["<C-d>"] = wrapped_delete_session,
						-- ["<C-s>"] = wrapped_alternate_session, -- NOTE: bugged in source
					},
				},
			},
		})

		telescope.load_extension("fzf")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fb", builtin.buffers, { desc = "buffer search" })
		keymap.set("n", "<leader>fqf", builtin.quickfix, { desc = "open quickfix" })
		keymap.set("n", "<leader>fds", builtin.lsp_document_symbols, { desc = "find symbols in file" })
	end,
}
