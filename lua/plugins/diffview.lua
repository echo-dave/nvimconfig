return {
	"sindrets/diffview.nvim",
	vim.api.nvim_set_keymap("n", "<leader>gd", ":DiffviewOpen<cr>", { noremap = true, silent = true }),
	vim.api.nvim_set_keymap("n", "<leader>gh", ":DiffviewFileHistory %<cr>", { noremap = true, silent = true }),
}
