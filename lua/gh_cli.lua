function gh_make_issue()
	vim.cmd("enew")
	vim.cmd("terminal")
	-- Get the buffer number of the terminal
	local bufnr = vim.api.nvim_get_current_buf()

	-- Get the channel (job ID) of the terminal
	local chan = vim.b[bufnr].terminal_job_id

	-- Send the command to the terminal
	vim.fn.chansend(chan, "gh issue create\n")
	vim.cmd("startinsert")
end

function gh_make_pr()
	vim.cmd("enew")
	vim.cmd("terminal")
	-- Get the buffer number of the terminal
	local bufnr = vim.api.nvim_get_current_buf()

	-- Get the channel (job ID) of the terminal
	local chan = vim.b[bufnr].terminal_job_id

	-- Send the command to the terminal
	vim.fn.chansend(chan, "gh pr create\n")
	vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>gmi", gh_make_issue)
vim.keymap.set("n", "<leader>gmp", gh_make_pr)
