if &compatible
	set nocompatible            " Be iMproved
endif

call plug#begin(expand('~/.config/nvim/plugged'))

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
	let g:make = 'make'
endif

" Vim enhancements
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'phaazon/hop.nvim'

" GUI
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'machakann/vim-highlightedyank'
Plug 'airblade/vim-gitgutter'
Plug 'navarasu/onedark.nvim'

" Semantic language

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Language support
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'fatih/vim-go'
Plug 'rust-lang/rust.vim'
Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'} 

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

call plug#end()

lua << EOF
require('onedark').setup()

require('hop').setup()
vim.api.nvim_set_keymap('n', '<leader>hw', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader>hl', "<cmd>:HopLine<cr>", {})

local lsp_status = require('lsp-status')
lsp_status.register_progress()

require('lualine').setup{
options = {theme = 'onedark'},
sections = {lualine_c = {"os.data('%a')", 'data', require'lsp-status'.status}}
}

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

require'nvim-treesitter.configs'.setup {
ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
highlight = {
enable = true,              -- false will disable the whole extension
additional_vim_regex_highlighting = false,
},
  indent = {
  enable = true,              -- false will disable the whole extension
  },
}

-- Semantic stuff

require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.phpactor.setup{}

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	--Enable completion triggered by <c-x><c-o>
	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
	-- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	-- Enable complete
	require'completion'.on_attach(client)
	require'lsp-status'.on_attach(client)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
nvim_lsp["rust_analyzer"].setup { 
	on_attach = on_attach,
	settings =  {
		["rust-analyzer"] = {
			assist = {
				importGranularity = "module",
				importPrefix = "by_self",
				},
			cargo = {
				loadOutDirsFromCheck = true
				},
			procMacro = {
			enable = true
			},
		}
	},
	capabilities = lsp_status.capabilities
}
local servers = { "tsserver", "gopls", "phpactor", "jsonls"}
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		capabilities = lsp_status.capabilities
	}
end

EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" rooter
let g:rooter_patterns = ['Rakefile', 'Cargo.toml', '.git/', 'composer.json']

if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
	nnoremap <leader>/ :Ag<space>
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
	nnoremap <leader>/ :Rg<space>
endif 

" Go
let g:go_disable_autoinstall = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_fmt_command = "goimports"

" Rust
let g:rustfmt_autosave = 1


