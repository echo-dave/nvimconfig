local mason_bin_path = vim.fn.stdpath("data") .. "/mason/bin/"
--
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
-- 	properties = {
-- 		"documentation",
-- 		"detail",
-- 		"additionalTextEdits",
-- 	},
-- }
-- capabilities.textDocument.semanticTokens.multilineTokenSupport = true
-- capabilities.textDocument.colorProvider = { dynamicRegistration = true }

local function convert_completion_item(item)
	print("complete")
	if item.kind == vim.lsp.protocol.CompletionItemKind.Color then
		print("is color")
		local color = item.label:match("#%x%x%x%x%x%x") or item.label:match("rgb%(%d+,%s*%d+,%s*%d+%)")
		if color then
			local hl_group = "LSP_Color_" .. color:gsub("#", ""):gsub(",", "_")
			vim.api.nvim_set_hl(0, hl_group, { bg = color })
			item.kind_hl_group = hl_group
		end
	end
	return item
end

local blink_cmp = require("blink.cmp")
local capabilities = blink_cmp.get_lsp_capabilities({ include_nvim_defaults = true })
return {
	"lsp",
	dir = vim.fn.stdpath("config") .. "/lua/plugins/lsp-conf",
	vim.lsp.config("*", {
		capabilities = capabilities,
		root_markers = { ".git" },

		on_init = function(client)
			local original_request = client.request
			client.request = function(method, params, callback, notify_id)
				if method == "textDocument/completion" then
					local wrapped_callback = function(err, result, ctx)
						if not err and result and result.items then
							for _, item in ipairs(result.items) do
								if item.kind == vim.lsp.protocol.CompletionItemKind.Color then
									if item.documentation then
										local color = item.documentation:match("#%x%x%x%x%x%x")
										if color then
											local group = "HexColor" .. color:sub(2)
											if vim.fn.hlID(group) < 1 then
												vim.api.nvim_set_hl(0, group, { fg = color, bold = true })
											end
											item.kind_hl = group
											item.kind_icon = "██" -- Add a color swatch icon
										end
									end
								end
							end
						end
						if callback then
							callback(err, result, ctx)
						end
					end
					return original_request(method, params, wrapped_callback, notify_id)
				end
				return original_request(method, params, callback, notify_id)
			end
		end,

		cmd_env = {
			PATH = mason_bin_path .. ":" .. vim.env.PATH,
		},
		vim.lsp.set_log_level("debug"),
		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "󰋼",
					[vim.diagnostic.severity.HINT] = "󰠠",
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = false,
		}),
	}),
	vim.lsp.enable({
		"lua_ls",
		"svelte",
		"ts_ls",
		"emmet_ls",
		"tailwind",
		"css_variables",
		"html",
		-- "css",
	}),
}
