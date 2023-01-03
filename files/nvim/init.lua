-- vim: syntax=lua
require "utils"


-- Be eMproved
vim.opt.compatible = false
vim.g.filetype = 'off'

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', vim.fn.stdpath('data') .. '/plugged')
-- Language support
Plug 'editorconfig/editorconfig-vim'
Plug('nvim-treesitter/nvim-treesitter', {['do']= ':TSUpdate'})

Plug 'rust-lang/rust.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug('fatih/vim-go', {['do']= ':GoUpdateBinaries'})
Plug 'jparise/vim-graphql'

-- LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp-status.nvim'
Plug('hrsh7th/nvim-cmp', {branch= 'main'})
Plug('hrsh7th/cmp-nvim-lsp', {branch= 'main'})
Plug('hrsh7th/cmp-buffer', {branch= 'main'})
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'rafamadriz/friendly-snippets'

Plug('folke/lsp-colors.nvim', {branch= 'main'})
Plug 'folke/trouble.nvim'

Plug 'nvim-lualine/lualine.nvim'

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
Plug 'alexghergh/nvim-tmux-navigation'
Plug 'numtostr/FTerm.nvim'

-- Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim', {['do']= 'make' })

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'


-- Color Schemes
Plug 'rose-pine/neovim'
Plug('f-person/auto-dark-mode.nvim', {commit= '9a7515c180c73ccbab9fce7124e49914f88cd763'})
vim.call('plug#end')

vim.opt.shell='/bin/zsh'
vim.opt.encoding = 'utf8'
vim.opt.swapfile = false

vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1

update_colors()

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
vim.opt.termguicolors = true
vim.opt.foldmethod = 'indent'
vim.opt.syntax = 'on'
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.scrolloff = 8

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
-- Spell checking for git commits
vim.cmd([[autocmd FileType gitcommit setlocal spell]])

vim.g.filetype = 'plugin indent on'
vim.opt.backspace='indent,eol,start'

-- Hidden buffers
vim.opt.hidden = true

-- Always spell check, since NeoVim 0.8 this only applies to comments when using TreeSitter.
vim.opt.spell = true

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

-- Rust
vim.g.rustfmt_autosave = 1

vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/snippets'

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


  require('rose-pine').setup({})
  vim.cmd('colorscheme rose-pine')
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
  vim.opt.foldmethod = 'indent'

  update_colors()
  vim.cmd('Limelight!')
end

vim.cmd('autocmd! User GoyoEnter nested :lua goyo_enter()')
vim.cmd('autocmd! User GoyoLeave nested :lua goyo_leave()')

vim.cmd('command! CargoCheck lua require("FTerm").scratch({ cmd = {"cargo", "check"} })')

-- auto-dark-mode
local auto_dark_mode = require('auto-dark-mode')

auto_dark_mode.setup({
  update_interval = 30000,
  set_dark_mode = function()
    set_dark_colors()
  end,
  set_light_mode = function()
    set_light_colors()
  end,
})
auto_dark_mode.init()

-- lualine
require('lualine').setup({
  sections= {
    lualine_y = {},
    lualine_c = {{
      'filename',
      path = 1,
    }},
    lualine_x = {"require'lsp-status'.status()", 'filetype'},
  }
})

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
  },
  extensions = {
    ["ui-select"] = {
      -- require("telescope.themes").get_dropdown {
      -- }
    }
  },
}
require("telescope").load_extension("ui-select")
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
  },
  renderer = {
    special_files = {
      'README.md',
      'Makefile',
      'MAKEFILE',
      'package.json',
      'Cargo.toml',
      '.gitignore'
    },
    icons = {
      show = {
          git= true,
          folder= true,
          file= true,
          folder_arrow= false,
        }
      }
    },
})

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "rust", "lua", "typescript", "cpp", "c", "css", "html", "javascript", "markdown", "markdown_inline", "go", "scss"
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
    { name = 'vsnip' },
    { name = 'path' }
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
}

local lsp_status = require('lsp-status')
lsp_status.register_progress()

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  lsp_status.on_attach(client)

  client.server_capabilities.document_formatting = false

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
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'gr', ":lua require'telescope.builtin'.lsp_references()<CR>", opts)
  buf_set_keymap('n', 'gi', ":lua require'telescope.builtin'.lsp_implementations()<CR>", opts)
  buf_set_keymap('n', '<leader>ld', ":lua require'telescope.builtin'.lsp_document_symbols()<CR>", opts)
  buf_set_keymap('n', '<leader>lw', ":lua require'telescope.builtin'.lsp_workspace_symbols()<CR>", opts)
  buf_set_keymap('n', '<leader>lW', ":lua require'telescope.builtin'.lsp_workspace_symbols({symbols={\"functions\"}})<CR>", opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

function on_init(client)
    local path = client.workspace_folders[1].name
    local lsp_settings = path .. "/.lsp-settings.json"

    if not file_exists(lsp_settings) then return true end
    local parsed = vim.json.decode(file_read(lsp_settings))

    local extra_settings = parsed[client.name]

    if extra_settings == nil then return true end

    client.config.settings = merge_tables(client.config.settings, extra_settings)
    client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })

    return true
end

function rust_open_docs()
  vim.lsp.buf_request(vim.api.nvim_get_current_buf(), 'experimental/externalDocs', vim.lsp.util.make_position_params(), function(err, url)
    if err then
      error(tostring(err))
    else
      local is_std = url:find("doc.rust-lang.org", 0, true)

      if is_std then
        -- Something from the standard library, open with dash instead.
        vim.cmd(':Dash!')
      else
        -- External crate
        vim.fn['netrw#BrowseX'](url, 0)
      end
    end
  end)
end

local servers = {
  rust_analyzer= {
    custom_attach= function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local opts = { noremap=true, silent=true }

      vim.api.nvim_create_user_command(
        'RustOpenDocs',
        rust_open_docs,
        { desc= 'Open documentation for the symbol under the cursor in default browser' }
      )

      buf_set_keymap('n', '<leader>d', '<cmd>RustOpenDocs<CR>', opts)
    end,
    settings= {
      ['rust-analyzer']= {
        checkOnSave = {
            allFeatures= true
        },
        assist= {
          importGranularity= "module"
        },
        cargo= {
          allFeatures= true,
        },
      }
    }
  },
  tsserver= {},
  gopls= {},
  clangd= {}
}
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
for lsp, extra in pairs(servers) do
  local custom_attach = nil

  if extra.custom_attach ~= nil then
    custom_attach = extra.custom_attach
    -- Set it to nil so the server doesn't explode when trying to serialize a function
    extra.custom_attach = nil
  end


  local config = {
    on_attach= function(client, bufnr)
      if custom_attach ~= nil then
        custom_attach(client, bufnr)
      end

      on_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150,
    },
    on_init=on_init,
  }

  local final_config = merge_tables(config, extra)

  nvim_lsp[lsp].setup(final_config)
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


-- vnsip
vim.cmd("imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<Tab>'")
vim.cmd("smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)' : '<Tab>'")
vim.cmd("imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<Tab>'")
vim.cmd("smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<Tab>'")

-- Match characters
-- The <ESC>i bit here has the effect of putting the insert mode cursor between
-- the pair of characters.
map('i', '(', '()<ESC>i', opts)
map('i', '[', '[]<ESC>i', opts)
map('i', '"', '""<ESC>i', opts)
-- map('i', "'", "''<ESC>i", opts) This mapping is annoying with Rust lifetimes 
map('i', '{', '{}<ESC>i', opts)
map('i', '`', '``<ESC>i', opts)
