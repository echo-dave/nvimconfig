local filetype_to_parser = {
	html = "tree-sitter/tree-sitter-html",
	css = "tree-sitter/tree-sitter-css",
	scss = "serenadeai/tree-sitter-scss",
	json = "tree-sitter/tree-sitter-json",
	yaml = "tree-sitter-grammars/tree-sitter-yaml",
	svelte = "tree-sitter-grammars/tree-sitter-svelte",
	python = "tree-sitter/tree-sitter-python",
	javascript = "tree-sitter/tree-sitter-javascript",
	typescript = "tree-sitter/tree-sitter-typescript",
	typescriptreact = "tree-sitter/tree-sitter-typescript",
	tsx = "tree-sitter/tree-sitter-typescript",
	bash = "tree-sitter/tree-sitter-bash",
	gitignore = "shunsambongi/tree-sitter-gitignore",
	query = "tree-sitter-grammars/tree-sitter-query",
	vimdoc = "neovim/tree-sitter-vimdoc",
	toml = "tree-sitter-grammars/tree-sitter-toml",
}

-- Extract unique parser repos
local parser_repos = {}
for _, repo in pairs(filetype_to_parser) do
	if not vim.tbl_contains(parser_repos, repo) then
		table.insert(parser_repos, repo)
	end
end

-- Build autocmd from filetype_to_parser keys
vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.tbl_keys(filetype_to_parser),
	callback = function()
		vim.treesitter.start()
	end,
})

-- TSInstall command
vim.api.nvim_create_user_command("TSInstall", function(opts)
	local langs
	if #opts.fargs > 0 then
		langs = table.concat(
			vim.tbl_map(function(ft)
				return filetype_to_parser[ft]
			end, opts.fargs),
			" "
		)
	else
		langs = table.concat(parser_repos, " ")
	end
	vim.fn.jobstart(string.format("build-nvim-parser %s", langs), {
		on_stdout = function(_, data)
			print(langs)
			if data then
				vim.notify(table.concat(data, "\n"), vim.log.levels.INFO)
			end
		end,
		on_exit = function(_, code)
			if code == 0 then
				vim.notify("Done", vim.log.levels.INFO)
			else
				vim.notify("Failed", vim.log.levels.ERROR)
			end
		end,
	})
end, {
	nargs = "*",
	complete = function()
		return vim.tbl_keys(filetype_to_parser)
	end,
})
