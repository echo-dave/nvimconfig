# NeoVim config info and reminders

## System Dependencies

> [!IMPORTANT]
>
> - [Neovim](https://github.com/neovim/neovim/releases) v0.10+ currently using v0.11 nightlies
> - [fzf](https://github.com/junegunn/fzf/releases) brew, apt (outdate), binary
> - [ripgrep](https://github.com/BurntSushi/ripgrep#installation) brew, apt (outdated), binary
> - some flavor of [Nerd Font](https://www.nerdfonts.com/font-downloads) for you client (if running remotely it's your client that needs the font not the server)
>
> If any Treesitter parsers are missing in the :checkhealth `:TSInstall <parser>`

## Plugin List

- [**lazy**](https://github.com/folke/lazy.nvim) - plugin managing
- [**mason**](https://github.com/williamboman/mason.nvim) - LSP, formatter, linter, DAP managing

- [**gitsigns**](https://github.com/lewis6991/gitsigns.nvim) - gutter indicator of changes, stage hunks or buffers, preview hunk changes, blame lines keymaps \<leader\>hp \<leader\>hs
- [**neogit**](https://github.com/NeogitOrg/neogit) - git for nvim with log, diff, and all the normal git commands :Neogit

- [**auto-session**](https://github.com/rmagatti/auto-session) - restoring working sessions
- [**bufferline**](https://github.com/akinsho/bufferline.nvim) - buffers as tabs with status - configurable as tabs of buffers
- [**nvim-autopairs**](https://github.com/windwp/nvim-autopairs) - add closing ) ] } etc
- [**colorscheme**](https://github.com/catppuccin/nvim) - choice of color scheme - catppuccin
- [**comment**](https://github.com/numToStr/Comment.nvim) - quickly commenting lines of code normal 'gbc' block 'gcc' line, visual 'gc', 'gcA' at end of line
- [**conform**](https://github.com/stevearc/conform.nvim) - better handling of formatters. Looks for prettierrc configs for current project
- [**dressing**](https://github.com/stevearc/dressing.nvim) - some ui visual things - looks like a lot of what Noice works with
- [**indent-blankline**](https://github.com/lukas-reineke/indent-blankline.nvim) - set indentation guide indicators
- [**lualine**](https://github.com/nvim-lualine/lualine.nvim) - status line options for git branch, diff, mode, hostname etc
- [**markdown**](https://github.com/MeanderingProgrammer/markdown.nvim) - markdown preview automatic in normal mode
- [**vim-maximizer**](https://github.com/szw/vim-maximizer) - toggle a split to full screen and back \<leader\>sm
- [**noice**](https://github.com/folke/noice.nvim) - UI customizations like relocating command input and search centrally on screen some lsp popup updates and message handling - :Noice errors for a popup of error messages
- [**nvim-cmp**](https://github.com/hrsh7th/nvim-cmp) - nvim auto completions - \<C-space\> show, \<C-e\> close, \<CR\> confirm
- [**nvim-tree**](https://github.com/nvim-tree/nvim-tree.lua) - file explorer
- [**nvim-surround**](https://github.com/tpope/vim-surround) - mappings for adding character around a selection \<C-s\>
- [**telescope**](https://github.com/nvim-telescope/telescope.nvim) - searches for files, buffers, strings. todos from todo-comments, sessions from auto-session
- [**todo-comments**](https://github.com/folke/todo-comments.nvim) - add todos as comments to files with //TODO: for JavaScript - highlighting and searchable
- [**nvim-tresitter**](https://github.com/tree-sitter/tree-sitter) - Nvim parser for syntax highlighting
- [**trouble**](https://github.com/folke/trouble.nvim) - diagnostics handler \<leader\>xx toggle diagnostics, \<leader\>cl toggle focus, \<leader\>xQ toggle quickfix list
- [**which-key**](https://github.com/folke/which-key.nvim) - popup list of key commands when you start a command - ie v for visual mode will popup with motions you can use
