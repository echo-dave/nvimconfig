return {
	"Exafunction/codeium.vim",
	event = "BufEnter",
	config = function()
		--  vim.keymap.set('i', '<C-g>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })

		vim.keymap.set("i", "<c-;>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })

		vim.keymap.set("i", "<m-;>", "<cmd>CodeiumToggle<cr>", { silent = true })

		vim.keymap.set("i", "<m-p>", function()
			return vim.fn["codeium#Complete"]()
		end, { expr = true, silent = true, noremap = true })

		-- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
		vim.keymap.set("i", "<c-x>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true })

		-- Toggle Codeium <m-;>
		-- Get Suggestions <m-p>
		-- Cycle Suggestions <c-;>
		-- Clear suggestions <c-x>

		-- vim.g.codeium_enabled = false
		vim.g.codeium_manual = true
		vim.g.condium_idle_delay = 1500
		vim.g.codeium_filetypes = {
			markdown = false,
			-- lua = false,
		}
	end,
}
