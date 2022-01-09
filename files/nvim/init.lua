-- vim: syntax=lua

-- Be eMproved
vim.opt.compatible = false
vim.g.filetype = 'off'

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')
-- Language support
Plug 'editorconfig/editorconfig-vim'
Plug('nvim-treesitter/nvim-treesitter', {['do']= ':TSUpdate'})

Plug 'cakebaker/scss-syntax.vim'
Plug 'vim-scripts/indentpython.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'keith/swift.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'plasticboy/vim-markdown'
Plug 'rust-lang/rust.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'udalov/kotlin-vim'
Plug 'uarun/vim-protobuf'
Plug('fatih/vim-go', {['do']= ':GoUpdateBinaries'})
Plug 'jparise/vim-graphql'

-- LSP
Plug 'neovim/nvim-lspconfig'
Plug('hrsh7th/nvim-cmp', {branch= 'main'})
Plug('hrsh7th/cmp-nvim-lsp', {branch= 'main'})
Plug('hrsh7th/cmp-buffer', {branch= 'main'})
Plug('folke/lsp-colors.nvim', {branch= 'main'})
Plug 'folke/trouble.nvim'

-- Airline
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

-- Altar of tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'

Plug 'airblade/vim-gitgutter'
Plug 'rizzatti/dash.vim'
Plug 'glepnir/dashboard-nvim'
Plug 'alexghergh/nvim-tmux-navigation'
Plug 'numtostr/FTerm.nvim'

-- Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', {['do']= 'make' })

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'


-- Color Schemes
Plug 'arcticicestudio/nord-vim'
Plug 'rose-pine/neovim'
vim.call('plug#end')

vim.opt.shell='/bin/zsh'
vim.opt.encoding = 'utf8'
vim.opt.swapfile = false

vim.cmd('colorscheme nord')
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1

vim.cmd([[
  hi! LspDiagnosticsDefaultError guifg=#dc322f gui=bold,standout
  hi! LspDiagnosticsDefaultWarning guifg=#b58900 gui=italic
  hi! LspDiagnosticsDefaultInformation guifg=#2aa198 gui=italic
  hi! LspDiagnosticsDefaultHint guifg=#2aa198 gui=italic cterm=italic
]])
vim.cmd("autocmd Filetype go setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 nolist")
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank()')

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.go.t_Co = '256'
vim.opt.background='dark'
vim.opt.termguicolors = true
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr="nvim_tresitter#foldexpr()"
vim.opt.syntax = 'on'
vim.opt.cursorline = true
vim.opt.cursorcolumn = false

vim.opt.ruler = true
vim.opt.colorcolumn = '120'
vim.cmd([[
  " From https://jeffkreeftmeijer.com/vim-number/
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]])

vim.g.filetype = 'plugin indent on'
vim.opt.backspace='indent,eol,start'

-- Hidden buffers
vim.opt.hidden = true

-- Python
vim.g.loaded_python_provider = 1
vim.g.python3_host_prog = '/Users/hugotunius/Envs/nvim/bin/python3'

vim.opt.smartcase = true
vim.opt.lazyredraw = true

vim.opt.list = true
vim.opt.listchars='eol:¬,trail:·'

-- Turn off modelines
vim.opt.modelines = 0
vim.opt.modeline = false

-- Editor config
vim.g.EditorConfig_exclude_patterns = {'fugitive://.*'}

-- vim-jsx
vim.g.jsx_ext_required = 0

-- vim-airline
vim.g.airline_powerline_fonts = 1
if (not vim.g.airline_symbols) then
      vim.g.airline_symbols = vim.empty_dict()
end
vim.g.airline_symbols.space = "\160"
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#show_buffers'] = 1
vim.opt.laststatus = 2
vim.g['airline#extensions#tabline#buffer_idx_mode'] = 1

-- Rust
vim.g.rustfmt_autosave = 1
vim.g.rustfmt_emit_files = 1
vim.g.rust_cargo_check_tests = 1

-- nvim-tree
-- List of filenames that gets highlighted with NvimTreeSpecialFile
vim.g.nvim_tree_special_files = { 
  ['README.md']= 1, 
  Makefile= 1, 
  MAKEFILE= 1,
  ['package.json']= 1,
  ['Cargo.toml']= 1,
  ['.gitignore']= 1
} 
vim.g.nvim_tree_show_icons = {
    git= 1,
    folders= 1,
    files= 1,
    folder_arrows= 0,
}
vim.g.nvim_tree_disable_window_picker = 0
function goyo_enter()
  vim.opt.spell = true
  vim.opt.autoindent = false
  vim.opt.list = false
  vim.opt.showmode = false
  vim.opt.showcmd = false
  vim.opt.spelllang = 'en_gb'
  vim.opt.complete:append('s')
  vim.opt.background = 'light'
  vim.opt.foldmethod = 'manual'

 
  require('rose-pine.functions').select_variant('dawn')
  vim.cmd('Limelight')
end

function goyo_leave()
  vim.opt.spell = false
  vim.opt.autoindent = true
  vim.opt.list = true
  vim.opt.showmode = true
  vim.opt.showcmd = true
  vim.opt.complete:remove('s')
  vim.opt.background = 'dark'
  vim.opt.foldmethod = 'syntax'

  vim.cmd('colorscheme nord')
  vim.cmd('Limelight!')
end

vim.cmd('autocmd! User GoyoEnter nested :lua goyo_enter()')
vim.cmd('autocmd! User GoyoLeave nested :lua goyo_leave()')

vim.cmd('command! CargoCheck lua require("FTerm").scratch({ cmd = {"cargo", "check"} })')

-- tmux-navigation
require'nvim-tmux-navigation'.setup {
    disable_when_zoomed = true -- defaults to false
}

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  },
  pickers = {
    buffers = {
      sort_mru = true,
      sort_lastused = true,
    }
  }
}
require('telescope').load_extension('fzf')

require("trouble").setup {}

require'nvim-web-devicons'.setup({
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
})

local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup({
  disable_netrw = false,
  view = {
    mappings = {
      list = {
        { key = {"C"}, cb = tree_cb("cd") }
      }
    }
  }
})
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "rust", "lua", "typescript", "cpp", "c", "css", "html", "javascript", "markdown"
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      print(vim.fn.pumvisible() ~= 1 or cmp.visible())
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn.pumvisible() ~= 0 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' }
  },
}

local servers = { 'rust_analyzer', 'tsserver', 'gopls', 'clangd' }
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  client.resolved_capabilities.document_formatting = false

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<f2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', ":lua require'telescope.builtin'.lsp_code_actions()<CR>", opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts) 
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts) 
  buf_set_keymap('n', 'gr', ":lua require'telescope.builtin'.lsp_references()<CR>", opts)
  buf_set_keymap('n', 'gr', ":lua require'telescope.builtin'.lsp_references()<CR>", opts)
  buf_set_keymap('n', 'gi', ":lua require'telescope.builtin'.lsp_implementations()<CR>", opts)
  buf_set_keymap('n', '<leader>ld', ":lua require'telescope.builtin'.lsp_document_symbols()<CR>", opts)
  buf_set_keymap('n', '<leader>lw', ":lua require'telescope.builtin'.lsp_workspace_symbols()<CR>", opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

local prettierd = {
  formatCommand = 'prettierd "${INPUT}"',
  formatStdin = true,
}

local languages = {
  css= { prettierd },
  html = { prettierd },
  javascript = { prettierd },
  javascriptreact = { prettierd },
  json = { prettierd },
  markdown = { prettierd },
  scss = { prettierd },
  typescript= { prettierd },
  typescriptreact= { prettierd },
  yaml = { prettierd }
}

nvim_lsp.efm.setup {
  filetypes = vim.tbl_keys(languages),
  init_options = { documentFormatting = true },
  settings = {
    languages = languages,
    rootMarkers = { ".git/", "package.json" },
  },
  flags = {
    debounce_text_changes = 150,
  },
}
vim.cmd([[autocmd! BufWritePre *.ts :lua vim.lsp.buf.formatting_seq_sync()]])
vim.cmd([[autocmd! BufWritePre *.tsx :lua vim.lsp.buf.formatting_seq_sync()]])
vim.cmd([[autocmd! BufWritePre *.js :lua vim.lsp.buf.formatting_seq_sync()]])
vim.cmd([[autocmd! BufWritePre *.css :lua vim.lsp.buf.formatting_seq_sync()]])
vim.cmd([[autocmd! BufWritePre *.json :lua vim.lsp.buf.formatting_seq_sync()]])

------------------------------------------
-- Key maps
------------------------------------------
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '
map('i', 'jk', '<ESC>', opts)

map('n', '<Leader>w', ':w<CR>', opts)
map('n', '<Leader>q', ':q<CR>', opts)
map('n', '<Leader>z', ':wq<CR>', opts)
map('n', '<Leader>s', ':sv<CR>', opts)
map('n', '<Leader>v', ':vs<CR>', opts)

-- Tmux navigation
map('n', "<C-h>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>", opts)
map('n', "<C-j>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>", opts)
map('n', "<C-k>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>", opts)
map('n', "<C-l>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>", opts)
map('n', "<C-\\>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>", opts)
map('n', "<C-Space>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>", opts)

-- System clipboard
map('v', '<Leader>y', '"+y', opts)
map('v', '<Leader>d', '"+d', opts)
map('n', '<Leader>p', '"+p', opts)
map('n', '<Leader>P', '"+P', opts)
map('v', '<Leader>p', '"+p', opts)
map('v', '<Leader>P', '"+P', opts)

-- Dash
map('n', '<leader>d', '<Plug>DashSearch', opts)
map('n', '<leader>D', '<Plug>DashGlobalSearch', opts)

-- Fugitive
map('n', '<leader>gb', ':Git blame<CR>', opts)
map('n', '<leader>gs', ':Git status<CR>', opts)
map('n', '<leader>gd', ':Git diff<CR>', opts)
map('n', '<leader>gc', ':Git commit<CR>', opts)
map('n', '<leader>gp', ':Git push<CR>', opts)
map('n', '<leader>gl', ':Git pull<CR>', opts)
map('n', '<leader>gh', ':GBrowse<CR>', opts)

vim.cmd('inoremap <expr><tab> pumvisible() ? "\\<c-n>" : "\\<tab>"')

map('n', '<F8>', ':NvimTreeToggle<CR>', opts)

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>bb', '<cmd>Telescope buffers<cr>', opts)


