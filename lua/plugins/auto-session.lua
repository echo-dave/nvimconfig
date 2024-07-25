return {
	"rmagatti/auto-session",
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local auto_session = require("auto-session")
		local session_lens = require("auto-session.session-lens")

		auto_session.setup({
			-- log_level = "error",
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },

			session_lens = {
				load_on_setup = true,
				previewer = false,
				theme_conf = { border = true },
				initial_mode = "normal",
				buftypes_to_ignore = {},
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
		keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
		keymap.set("n", "<leader>fws", session_lens.search_session, {
			noremap = true,
			desc = "Tele session picker",
		})
	end,
}
