
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.title = true     -- Show the title in the menu bar
vim.opt.shell = '/bin/bash' -- Force bash as shell
vim.opt.lcs='tab:▸ ,trail:·,eol:¬,nbsp:_' -- Invisible chars
vim.opt.termguicolors = false


-- ========================================================================== --
-- ==                             KEYBINDINGS                              == --
-- ========================================================================== --

-- Space as leader key
vim.g.mapleader = ' '

-- Shortcuts
vim.keymap.set({'n', 'x', 'o'}, '<leader>h', '^')
vim.keymap.set({'n', 'x', 'o'}, '<leader>l', 'g_')
vim.keymap.set('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

-- Basic clipboard interaction
vim.keymap.set({'n', 'x'}, 'cp', '"+y')
vim.keymap.set({'n', 'x'}, 'cv', '"+p')

-- Commands
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>bq', '<cmd>bdelete<cr>')
vim.keymap.set('n', '<leader>bl', '<cmd>buffer #<cr>')

-- Strip spaces
vim.cmd [[
" Strip trailing whitespace (<leader>ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
"noremap <leader>ss :call StripWhitespace()<CR>
]]
vim.keymap.set('n', '<leader>ss', ':call StripWhitespace()<cr>')

-- Show Invisible chars
vim.keymap.set('n', '<leader>in', ':set invlist<cr>:set list?<cr>')

-- Show conflicts
vim.keymap.set('n', '<leader>fc', '<ESC>/\\v^[<=>]{7}( .*\\|$)<CR>')

-- Disable ex mode
vim.keymap.set('n', 'Q', '<nop>')


-- ========================================================================== --
-- ==                               COMMANDS                               == --
-- ========================================================================== --

vim.api.nvim_create_user_command('ReloadConfig', 'source $MYVIMRC', {})

local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight on yank',
	group = group,
	callback = function()
		vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = {'help', 'man'},
	group = group,
	command = 'nnoremap <buffer> q <cmd>quit<cr>'
})


-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazy = {}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print('Installing lazy.nvim....')
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable', -- latest stable release
			path,
		})
	end
end

function lazy.setup(plugins)
	-- You can "comment out" the line below after lazy.nvim is installed
	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)
	require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
	-- Colors
	{'navarasu/onedark.nvim'},
	-- Movement
	{'phaazon/hop.nvim'},
	{'tpope/vim-surround'},
--	-- Semantic
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	-- Fuzzy finder
	{'airblade/vim-rooter'},
	{'nvim-lua/plenary.nvim'},
	{'nvim-telescope/telescope.nvim'},
	-- Status line
	{'nvim-lua/lsp-status.nvim'},
	{'nvim-lualine/lualine.nvim'},
	-- LSP
{
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v1.x',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},         -- Required
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'saadparwaiz1/cmp_luasnip'}, -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

    -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    {'rafamadriz/friendly-snippets'}, -- Optional
  }
}
})


-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

-- Colorscheme
require('onedark').setup{
	style = 'darker'
}
require('onedark').load()

-- Movement

require('hop').setup()
vim.api.nvim_set_keymap('n', '<leader>hw', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>hl', "<cmd>:HopLine<cr>", {})

-- Semantic

require'nvim-treesitter.configs'.setup {
	ensure_installed = {'python','php','lua','c','rust','go','javascript','typescript','json','html','vim'},
	highlight = {
		enable = true,              -- false will disable the whole extension
		additional_vim_regex_highlighting = false,
		},
	indent = {
		enable = true,              -- false will disable the whole extension
		},
}

-- Fuzzy finder

require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
	}
}
vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files{}<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>lua require'telescope.builtin'.buffers{}<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>tb', "<cmd>lua require'telescope.builtin'.file_browser{}<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>tg', "<cmd>lua require'telescope.builtin'.live_grep{}<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>ld', "<cmd>lua require'telescope.builtin'.lsp_definitions{}<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>li', "<cmd>lua require'telescope.builtin'.lsp_implementations{}<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>la', "<cmd>lua require'telescope.builtin'.lsp_code_actions{}<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>lr', "<cmd>lua require'telescope.builtin'.lsp_references{}<cr>", {})

-- Status line

vim.opt.showmode = false
require('lualine').setup({
	options = {
		icons_enabled = false,
		theme = 'onedark',
		component_separators = '|',
		section_separators = '',
	},
	sections = {lualine_c = {"os.data('%a')", 'data', require'lsp-status'.status}}
})

-- LSP
local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
