local M = {}

M.toggle_theme = function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
		vim.cmd("colorscheme catppuccin-latte")
	else
		vim.o.background = "dark"
		vim.cmd("colorscheme catppuccin-mocha")
	end
end

-- Create a global command
vim.api.nvim_create_user_command("ToggleTheme", M.toggle_theme, {})

return M
