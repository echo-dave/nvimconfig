return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
	},
	-- auto refresh after commit
	-- vim.api.nvim_create_autocmd("User", {
	-- 	pattern = "NeogitCommitPre",
	-- 	callback = function()
	-- 		require("neogit").refresh()
	-- 	end,
	-- }),
	config = true,
}
