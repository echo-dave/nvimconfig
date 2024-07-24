return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local lualine = require("lualine")
		local noice = require("noice")
		local recStatus
		local function shortened_hostname()
			local hostname = vim.loop.os_gethostname()
			local short_hostname = hostname:match("^([^%.]+)")
			return short_hostname or hostname
		end

		local function hostnameOrRec()
			local noiceRec = noice.api.status.mode
			if noiceRec.has() then
				return noiceRec.get()
			else
				return shortened_hostname()
			end
		end

		lualine.setup({
			options = {
				icons = true,
				component_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "filename" },
				lualine_c = { "branch", "diff", "diagnostics" },
				lualine_x = { "filetype" },
				lualine_y = {
					"searchcount",
					-- {
					-- 	require("noice").api.status.mode.get,
					-- 	cond = require("noice").api.status.mode.has,
					-- 	color = { fg = "#ff9e64" },
					-- },
				},
				lualine_z = {
					{
						hostnameOrRec,
						cond = function()
							recStatus = noice.api.status.mode.has()
							-- print("status rec:", recStatus)
							return recStatus
						end,
						color = { fg = "#ff9e64", bg = "#181825" }, -- #181825 dark blue
					},
					{
						shortened_hostname,
						cond = function()
							-- print("status host:", not recStatus)
							return not recStatus
						end,
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
