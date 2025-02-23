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
					pane = 1,
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
							height = 8,
							padding = { 0, -1 }, --bottom, top
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
					indent = 3,
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
		notifier = {
			enabled = false,
			level = "trace",
			history = {
				filter = "trace", -- This will capture all levels of notifications
				sort = { "added" },
				reverse = true, -- Most recent notifications first
			},
		},
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
	keys = {
		-- {
		-- 	"<leader>n",
		-- 	function()
		-- 		Snacks.notifier.show_history()
		-- 	end,
		-- 	desc = "Notification History",
		-- },
		{
			"<leader>ss",
			function()
				require("snacks.dashboard").open()
			end,
			desc = "Open Snacks Dashboard",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>fp",
			function()
				require("snacks.picker").pick({
					source = "projects",
					focus = "list",
				})
			end,
			desc = "Projects",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>sf",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
	},
}
