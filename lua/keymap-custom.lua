-- set leader key to space
vim.g.mapleader = " "

vim.api.nvim_create_user_command("LspAllInfo", function()
	local clients = vim.lsp.get_clients({ all = true })
	for _, client in ipairs(clients) do
		local status = client:is_stopped() and "Inactive" or "Active"
		print(string.format("Client: %s (ID: %d) - Status: %s", client.name, client.id, status))
		print("  Root directory: " .. (client.config.root_dir or "Not set"))
		print("  Attached buffers: " .. vim.inspect(vim.lsp.get_buffers_by_client_id(client.id)))
		print("------------------")
	end
end, {})

vim.api.nvim_create_user_command("LspInfo", function()
	print(vim.inspect(vim.lsp.get_clients()))
end, {})

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("t", "<ESC><ESC>", "<C-\\><C-N>", { noremap = true, desc = "return terminal to normal mode" })
-- keymap.set("t", "<leader><ESC>", "<C-\\><C-N>", {noremap = "true", desc = "return terminal to normal mode"})

keymap.set("v", "//", 'y/<C-r>"<CR>', { noremap = true, silent = true, desc = "visual search selected" })

keymap.set("x", "p", "P", { noremap = true, desc = "paste without replacing clip" })
keymap.set("n", "<leader>scr", ':let @/ = ""<CR>', { noremap = true, desc = "Search Register Clear" })
