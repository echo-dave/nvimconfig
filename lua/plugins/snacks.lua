local function getbranch()
	local cmd = "git branch --show-current"
	local branchName = vim.fn.system(cmd):gsub("\n", "")
	return "Git Branch Status: " .. (branchName ~= "" and branchName or "not in a git repository")
end
local branch = getbranch()
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = false },
		dashboard = {

			sections = {
				{ section = "header", pane = 1, width = vim.o.columns },

				-- {
				-- 	pane = 2,
				-- 	section = "terminal",
				-- 	-- cmd = "colorscript -e square",
				-- 	height = 5,
				-- 	padding = 1,
				-- },
				-- { section = "keys", gap = 1, padding = 1 },
				-- {
				-- 	pane = 2,
				-- 	icon = " ",
				-- 	desc = "Browse Repo",
				-- 	padding = 1,
				-- 	key = "b",
				-- 	action = function()
				-- 		Snacks.gitbrowse()
				-- 	end,
				-- },
				function()
					local in_git = Snacks.git.get_root() ~= nil
					local cmds = {
						-- {
						-- 	title = "Notifications",
						-- 	cmd = "gh notify -s -a -n5",
						-- 	action = function()
						-- 		vim.ui.open("https://github.com/notifications")
						-- 	end,
						-- 	key = "n",
						-- 	icon = " ",
						-- 	height = 5,
						-- 	enabled = true,
						-- },
						-- {
						-- 	title = "Open Issues",
						-- 	cmd = "gh issue list -L 3",
						-- 	key = "i",
						-- 	action = function()
						-- 		vim.fn.jobstart("gh issue list --web", { detach = true })
						-- 	end,
						-- 	icon = " ",
						-- 	height = 7,
						-- },
						{
							icon = " ",
							title = "Open PRs",
							cmd = "gh pr list -L 3",
							key = "P",
							action = function()
								vim.fn.jobstart("gh pr list --web", { detach = true })
							end,
							height = 7,
						},
						{
							icon = " ",
							title = branch,
							align = "center",
							cmd = "echo ''",
							padding = { 0, 0 }, --bottom, top
							height = 1,
						},
						{
							cmd = "git --no-pager diff --stat -B -M -C",
							height = 10,
							padding = { 0, 0 }, --bottom, top
						},
					}
					return vim.tbl_map(function(cmd)
						return vim.tbl_extend("force", {
							section = "terminal",
							pane = 2,
							align = "left",
							enabled = in_git,
							ttl = 5 * 60,
							indent = 3,
							width = 50,
						}, cmd)
					end, cmds)
				end,
				{
					section = "recent_files",
					title = "Rrecent Files",
					limit = 5,
					padding = { 1, 0 }, --bottom, top
					pane = 3,
					width = 10,
					align = "left",
				},
				{ section = "startup" },
			},
		},
		explorer = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true, timeout = 5000 },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
	keys = {
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>sd",
			function()
				require("snacks.dashboard").open()
			end,
			desc = "Open Snacks Dashboard",
		},
	},
}
