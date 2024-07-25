# NeoVim config info and reminders

## System Dependencies

> [!IMPORTANT]
>
> - [Neovim](https://github.com/neovim/neovim/releases) v0.10+ currently using v0.11 nightlies
> - [fzf](https://github.com/junegunn/fzf/releases) brew, apt (outdate), binary
> - [ripgrep](https://github.com/BurntSushi/ripgrep#installation) brew, apt (outdated), binary
> - some flavor of [Nerd Font](https://www.nerdfonts.com/font-downloads) for your client (if running remotely it's your client terminal that needs the font not the server)
>
> If any Treesitter parsers are missing in the :checkhealth `:TSInstall <parser>`

> [!NOTE]
>
> - Some tweaks are small screen specific - mostly messages
> - The coding setup is your basic HTML, CSS, Tailwind, JavaScript, and TypeScript with Svelte(Kit)
> - Configured with modular Lazy and Mason with git suppert via GitSigns and Neogit

## Plugin List

| [#Git](#git) | [#Coding-Centric](#coding-centric-formatters-and-code-helpers) | [#UI-Related](#ui-related) | [#Utility](#utility) |
| ------------ | -------------------------------------------------------------- | -------------------------- | -------------------- |

### Managers

- [**lazy**](https://github.com/folke/lazy.nvim) - plugin managing
- [**mason**](https://github.com/williamboman/mason.nvim) - LSP, formatter, linter, DAP managing

### Git

- [**gitsigns**](https://github.com/lewis6991/gitsigns.nvim) - gutter indicator of changes, stage hunks or buffers, preview hunk changes, blame lines keymaps `<leader>hp` `<leader>hs`
- [**neogit**](https://github.com/NeogitOrg/neogit) - git for nvim with log, diff, and all the normal git commands `:Neogit`

### Coding-Centric Formatters and Code Helpers

- [**comment**](https://github.com/numToStr/Comment.nvim) - quickly commenting lines of code normal `gbc` block `gcc` line, visual `gc`, `gcA` at end of line
- [**conform**](https://github.com/stevearc/conform.nvim) - better handling of formatters. Configured to use prettierrc for current project
- [**nvim-autopairs**](https://github.com/windwp/nvim-autopairs) - add closing ) ] } etc
- [**nvim-cmp**](https://github.com/hrsh7th/nvim-cmp) - nvim auto completions - `<C-space>` show, `<C-e>` close, `<CR>` confirm
- [**nvim-surround**](https://github.com/tpope/vim-surround) - mappings for adding character around a selection `<C-s>`
- [**nvim-tresitter**](https://github.com/tree-sitter/tree-sitter) - Nvim parser for syntax highlighting
- [**todo-comments**](https://github.com/folke/todo-comments.nvim) - add todos as comments to files with **'TODO:'** **'BUG:'** **'WARN:'** etc for highlighting and searchable - integrates with telescope `<leader>ft`
- [**trouble**](https://github.com/folke/trouble.nvim) - diagnostics handler `<leader>xx` toggle diagnostics, `<leader>cl` toggle focus, `<leader>xQ` toggle quickfix list

### UI Related

- [**colorscheme**](https://github.com/catppuccin/nvim) - choice of color scheme config for catppuccin
- [**dressing**](https://github.com/stevearc/dressing.nvim) - some ui visual things - moves some dialogs out of the bottom left foe better visibility / readability like nvim-tree add or rename files
- [**indent-blankline**](https://github.com/lukas-reineke/indent-blankline.nvim) - set indentation guide indicators
- [**lualine**](https://github.com/nvim-lualine/lualine.nvim) - status line options for git branch, diff, better mode visibility, hostname etc
- [**noice**](https://github.com/folke/noice.nvim) - UI customizations like relocating command input and search centrally on screen some lsp popup updates and message handling - :Noice errors for a popup of error messages

### Utility

- [**auto-session**](https://github.com/rmagatti/auto-session) - save and restoring working sessions - integrates with telescope
- [**bufferline**](https://github.com/akinsho/bufferline.nvim) - buffers as tabs with status - configurable as tabs of buffers
- [**markdown**](https://github.com/MeanderingProgrammer/markdown.nvim) - markdown preview automatic in normal mode
- [**vim-maximizer**](https://github.com/szw/vim-maximizer) - toggle a split to full screen and back `<leader>sm`
- [**nvim-tree**](https://github.com/nvim-tree/nvim-tree.lua) - file explorer `<C-]>` set cwd, `-` to go up a level, `a` add, `r` rename, `d` delete, `m` mark, `bmv` move mark
- [**telescope**](https://github.com/nvim-telescope/telescope.nvim) - searches for files, buffers, strings. todos from todo-comments, sessions from auto-session
- [**which-key**](https://github.com/folke/which-key.nvim) - popup list of key commands when you start a command - ie v for visual mode will popup with motions you can use

## Keymaps

| [#Search](#search) | [#Motions](#basic-motions) | [#Maintenance](#maintenance) | [#Spell](#spell-correction) | [#Others](#others) |
| ------------------ | -------------------------- | ---------------------------- | --------------------------- | ------------------ |

`<leader>` is mapped to SPACE in the options.lua

### Search

`/` search buffer  
`:s/seach/replace/g` search and replace a line  
`:%s/search/replace/gc` search and replace buffer with confirmation  
`:Telescope lsp_definitions` go to current function definition  
`<leader>ff` find files  
`<leader>fs` find strings  
`<leader>ft` find todos

### Basic Motions

`f` followed by character goes to next instance - prepend number to skip  
`0` go to start of line  
`$` go to end of line  
`a` append after cursor  
`A` append end of line  
`i` insert before cursor  
`I` insert start of line  
`]h` next hunk  
`[h` previous hunk

### Maintenance

`:checkhealth` Lazy check health of setup and plugin dependencies  
`:Mason` update and install LSP, formatters, linters, etc  
`:Lazy` update and install configured plugins

### Spell Correction

`:set spell` enable builtin spell checker  
`:set nospell` disable spell checker  
`]s` next misspelled  
`[s` previous misspelled  
`z=` suggest corrections  
`zg` add to correct words

### Others

`<C-e>` close auto complete without confirmation - should close lsp popups too  
`q` close nvim-tree pane if focus otherwise `<leader>ee`  
`q` close neogit and popups like `:Lazy` or `:Mason` interfaces and the `:Noice errors` popup  
`:term` open a terminal  
`<ESC><ESC>` exit insert mode in a terminal buffer  
`:Neogit commit` `:Neogit push` do git things

<hr />

> [!NOTE]  
> A lot of my initial setup was thanks to inspiration from [Josean Martinez's setup](https://www.josean.com/posts/how-to-setup-neovim-2024)
