local function shorten_path(full_path)
	return vim.fn.fnamemodify(full_path, ":~")
end
local ghformat =
	'\'{{range .}}{{$color := ""}}{{if eq .state "OPEN"}}{{$color = "green"}}{{else if eq .state "MERGED"}}{{$color = "magenta"}}{{else}}{{$color = "red"}}{{end}}{{tablerow (printf "#%v" .number | autocolor $color) .title (join "|" (pluck "name" .labels) | autocolor "blue") (timeago .updatedAt)}}{{end}}\''

local function runterm(command)
	vim.cmd("enew")
	vim.cmd("terminal")
	-- Send the gh notify command to the terminal
	vim.api.nvim_chan_send(vim.b.terminal_job_id, command .. "\n")
	vim.cmd("startinsert")
end
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
				{
					title = "Notifications",
					cmd = [[gh notify -sn 5 | awk 'function truncate(str, width) {                                                                                                           
    if (length(str) > width - 2) {                                                                                                          
      return substr(str, 1, width - 2) ".."                                                                                                 
    } else {                                                                                                                                
      return str                                                                                                                            
    }}                                                                                                                                                                                                                                                                          
{print $1,$2,truncate($4,30),$6}' | sed "s/\ /,/g" | cut -c 1-85| column -t -s ","
]],
					-- cmd = [[gh notify -sn 5 | awk '{print $1,$2,$4,$5,$6}' | sed 's/\ /,/g' | column -t -s ',' -c 80]],
					-- cmd = "gh notify -sn 5 | cut -c 1-110",
					section = "terminal",
					action = function()
						runterm("gh notify")
					end,
					key = "n",
					icon = " ",
					height = 5,
					enabled = true,
					pane = 1,
					padding = { 1, 0 }, --bottom, top
				},
				function()
					local in_git = Snacks.git.get_root() ~= nil
					local cmds = {
						{
							title = "Issues",
							cmd = "gh issue list --state all -L 5 --json number,title,state,labels,updatedAt --template "
								.. ghformat,
							key = "i",
							action = function()
								runterm("gh issue list -s all")
							end,
							icon = " ",
							height = 5,
							padding = { 1, 0 }, --bottom, top
						},
						{
							icon = " ",
							title = "PRs: magenta merged",
							cmd = "gh pr list --state all -L 5 --json number,title,updatedAt,labels,state -t "
								.. ghformat,
							key = "P",
							action = function()
								runterm("gh pr list -s all")
							end,
							height = 5,
						},
						{
							icon = " ",
							title = (function()
								local branchName = vim.fn.system("git branch --show-current"):gsub("\n", "")
								return "Git Branch Status: "
									.. (branchName ~= "" and branchName or "not in a repository")
							end)(),
							align = "center",
							cmd = "git --no-pager diff --stat -B -M -C",
							padding = { 0, 0 }, --bottom, top
							height = 8,
						},
						-- {
						-- 	cmd = "git --no-pager diff --stat -B -M -C",
						-- 	height = 8,
						-- 	padding = { 0, -1 }, --bottom, top
						-- },
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
					icon = " ",
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
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
	},
}
