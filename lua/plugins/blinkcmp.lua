return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	-- dependencies = { "rafamadriz/friendly-snippets" },

	-- use a release tag to download pre-built binaries
	version = "*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = {
			preset = "default",
			["<c-k>"] = { "select_prev", "fallback" },
			["<c-j>"] = { "select_next", "fallback" },
			-- ["<CR>"] = { "accept", "fallback" },
			["<c-e>"] = { "hide_documentation", "hide" },
		},
		cmdline = {
			enabled = false,
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
				treesitter_highlighting = true,
				draw = function(opts)
					opts.default_implementation()
				end,
				window = {
					min_width = 10,
					max_width = 45,
					max_height = 10,
					border = "padded",
					winblend = 0,
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
					-- Note that the gutter will be disabled when border ~= 'none'
					scrollbar = true,
					-- Which directions to show the documentation window,
					-- for each of the possible menu window directions,
					-- falling back to the next direction when there's not enough space
					direction_priority = {
						menu_north = { "e", "w", "n", "s" },
						menu_south = { "e", "w", "s", "n" },
					},
				},
			},
			list = { max_items = 15, selection = { preselect = true, auto_insert = false } },

			menu = {
				border = "single",
				-- don't show when searching
				auto_show = function(ctx)
					return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
				end,
				draw = {
					align_to = "label",
					-- Left and right padding, optionally { left, right } for different padding on each side
					padding = 1,
					-- Gap between columns
					gap = 2,
					columns = {
						{ "kind_icon", "label", gap = 1 },
						{ "kind", "label_description", gap = 1 },
						-- { "source_name" },
					},
					treesitter = { "lsp" },
					components = {
						label = {
							width = { fill = true, max = 60 },
						},
						label_description = {
							width = { max = 30 },
							text = function(ctx)
								return ctx.label_description
							end,
							highlight = "BlinkCmpLabelDescription",
						},
						source_name = {
							width = { max = 30 },
							text = function(ctx)
								return ctx.source_name
							end,
							highlight = "BlinkCmpSource",
						},
					},
				},
			},
			trigger = {
				show_on_keyword = true,
				prefetch_on_insert = true,
				show_in_snippet = true,
				show_on_trigger_character = true,
				show_on_blocked_trigger_characters = { " ", "\n", "\t" },
				show_on_accept_on_trigger_character = false,
				show_on_insert_on_trigger_character = true,
				show_on_x_blocked_trigger_characters = { "'", '"', "(" },
			},
		},
		fuzzy = {
			implementation = "prefer_rust_with_warning",
			max_typos = function(keyword)
				return math.floor(#keyword / 2)
			end,
			frecency = {
				enabled = true,
				unsafe_no_lock = true,
			},
			use_proximity = true,
			sorts = { "score", "sort_text" },
			prebuilt_binaries = {
				download = true,
				ignore_version_mismatch = false,
				force_version = nil,
				force_system_tripple = nil,
				extra_curl_args = {},
			},
		},

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = false,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		-- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			providers = {
				cmdline = {
					-- ignores cmdline completions when executing shell commands
					enabled = function()
						return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
					end,
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100, -- Show at a higher priority than LSP
				},
				lsp = {
					name = "LSP",
					module = "blink.cmp.sources.lsp",
					fallbacks = { "buffer" },
					--- These properties apply to !!ALL sources!!
					--- NOTE: All of these options may be functions to get dynamic behavior
					--- See the type definitions for more information
					enabled = true, -- Whether or not to enable the provider
					async = true, -- Whether we should wait for the provider to return before showing the completions
					timeout_ms = 1000, -- How long to wait for the provider to return before showing completions and treating it as asynchronous
					-- transform_items = nil, -- Function to transform the items before they're returned
					should_show_items = true, -- Whether or not to show the items
					max_items = 15, -- Maximum number of items to display in the menu
					min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
					-- If this provider returns 0 items, it will fallback to these providers.
					-- If multiple providers falback to the same provider, all of the providers must return 0 items for it to fallback
					-- fallbacks = {},
					score_offset = 90, -- Boost/penalize the score of the items
				},
			},
		},
	},
	opts_extend = { "sources.default" },
}
