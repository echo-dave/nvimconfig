local function getbranch()
	local cmd = "git branch --show-current"
	local branchName = vim.fn.system(cmd):gsub("\n", "")
	return "Git Branch Status: " .. (branchName ~= "" and branchName or "not in a git repository")
end
local branch = getbranch()
local ghformat =
	'\'{{range .}}{{color "green" (printf "#%v" .number | printf "%-2s")}} {{.title | printf "%-20.20s"}} {{range .labels}}[{{.name | printf "%-.6s"}}]{{end}} {{timeago .updatedAt}}\n{{end}}\''
local function shorten_path(full_path)
	return vim.fn.fnamemodify(full_path, ":~")
end
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = false },
		dashboard = {
			sections = {
				{
					title = "Notifications",
					cmd = "gh notify -san 4",
					section = "terminal",
					action = function()
						vim.ui.open("https://github.com/notifications")
					end,
					key = "n",
					icon = " ",
					height = 8,
					enabled = true,
				},
				function()
					local in_git = Snacks.git.get_root() ~= nil
					local cmds = {
						{
							title = "Open Issues",
							cmd = "gh issue list -L 3 --json number,title,updatedAt,labels -t " .. ghformat,
							key = "i",
							action = function()
								vim.fn.jobstart("gh issue list --web", { detach = true })
							end,
							icon = " ",
							height = 7,
							padding = { 1, 0 }, --bottom, top
						},
						{
							icon = " ",
							title = "Open PRs",
							cmd = "gh pr list -L 3 --json number,title,updatedAt,labels -t " .. ghformat,
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
					pane = 3,
					icon = " ",
					title = "Projects",
					section = "projects",
					action = function(item)
						vim.cmd("PossessionLoad " .. shorten_path(item))
					end,
					indent = 2,
					padding = 1,
				},
				{
					section = "recent_files",
					title = "Recent Files",
					cwd = true,
					limit = 5,
					padding = { 1, 0 }, --bottom, top
					pane = 3,
					width = 10,
					align = "left",
					indent = 2,
				},
				{ section = "startup" },
			},
		},
		explorer = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		notifier = { enabled = true, timeout = 4000 },
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
			"<leader>ss",
			function()
				require("snacks.dashboard").open()
			end,
			desc = "Open Snacks Dashboard",
		},
	},
}
