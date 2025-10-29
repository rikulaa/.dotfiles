-- #################
-- Plugin settings
-- #################
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  use 'github/copilot.vim'

  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'

  use 'stevearc/conform.nvim'

  use  {
    'nvim-treesitter/nvim-treesitter',
    tag = 'v0.9.2',
      run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,

  }
  use 'nelsyeung/twig.vim'
  -- TODO: update to latest treesitter in order to use this
  -- use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- Use treesitter to autoclose and autorename html tag
  use 'windwp/nvim-ts-autotag' 

  -- For project specific settings (.nvimrc.lua, .nvimrc, etc.)
  use 'MunifTanjim/exrc.nvim'

  use "junegunn/fzf"
  use "junegunn/fzf.vim"

  use "windwp/nvim-autopairs"
  use 'mtikekar/nvim-send-to-term'

  -- Lua
  use "folke/which-key.nvim"

  use 'ionide/Ionide-vim'

  -- TODO: get rid of this
  use "SirVer/ultisnips"

  use 'tpope/vim-surround'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-abolish'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  use { "catppuccin/nvim", as = "catppuccin" }
  use 'morhetz/gruvbox'
  use 'arcticicestudio/nord-vim'
end)

-- LSP setup
local nvim_lsp = vim.lsp

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- this get's overwritten due to some reason?
  vim.opt_local.autoindent = true

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', '<C-LeftMouse>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<F3>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('i', '<F3>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<F5>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'grr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_set_keymap('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gra', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  --buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format({ async = true})<CR>', opts)
  buf_set_keymap('v', '<leader>lf', ':lua vim.lsp.buf.range_formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>ls', '<cmd>FzfLua lsp_document_symbols<CR>', opts)
  buf_set_keymap('n', '<leader>lS', '<cmd>FzfLua lsp_workspace_symbols<CR>', opts)
  buf_set_keymap('n', '<leader>olr', '<cmd>LspRestart<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', {})
  buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {})
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach_omnisharp = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- this get's overwritten due to some reason?
  vim.opt_local.autoindent = true

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua require("omnisharp_extended").lsp_type_definition()<cr>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua require("omnisharp_extended").lsp_definition()<cr>', opts)
  -- buf_set_keymap('n', '<C-LeftMouse>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>li', '<cmd>lua require("omnisharp_extended").lsp_implementation()<cr>', opts)
  buf_set_keymap('n', '<F3>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('i', '<F3>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<F5>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'grr', '<cmd>lua require("omnisharp_extended").lsp_references()<cr>', opts)
  buf_set_keymap('n', 'gri', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gO', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  buf_set_keymap('n', 'grn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gra', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  --buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.format({ async = true})<CR>', opts)
  buf_set_keymap('v', '<leader>lf', ':lua vim.lsp.buf.range_formatting()<CR>', opts)
  buf_set_keymap('n', '<leader>ls', '<cmd>FzfLua lsp_document_symbols<CR>', opts)
  buf_set_keymap('n', '<leader>lS', '<cmd>FzfLua lsp_workspace_symbols<CR>', opts)
  buf_set_keymap('n', '<leader>olr', '<cmd>LspRestart<CR>', opts)
  buf_set_keymap('n', ']e', '<cmd>lua vim.diagnostic.goto_next()<CR>', {})
  buf_set_keymap('n', '[e', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup lspconfig.
-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- tsserver https://github.com/typescript-language-server/typescript-language-server
-- Python: https://github.com/python-lsp/python-lsp-server
-- php (intelephense): https://intelephense.com/
-- eslint: You need to instrall 'vscode-langservers-extracted' from npm
-- vuels https://github.com/vuejs/language-tools/wiki/Neovim
-- remove eslint and vuels
local servers = { 'pylsp', 'ts_ls', 'astro', 'svelte', 'eslint', 'gopls', 'html' , 'jsonls', 'vls', 'omnisharp' }
for _, lsp in ipairs(servers) do
  nvim_lsp.config[lsp] = {
    on_attach = on_attach,
    cababilities = cababilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
  nvim_lsp.enable(lsp)

end
-- TODO: configure these more declaratively
nvim_lsp.config['vuels'] = {
  on_attach = on_attach,
  cababilities = cababilities,
  cmd = {'vue-language-server'},
  flags = {
    debounce_text_changes = 150,
  },
}
nvim_lsp.enable('vuels')

nvim_lsp.config['elixirls'] = {
  on_attach = on_attach,
  cababilities = cababilities,
  cmd = {'elixir-ls'},
  flags = {
    debounce_text_changes = 150,
  },
}
nvim_lsp.enable('elixirls')

nvim_lsp.config['intelephense'] = {
  -- Enable wordpress support
  settings = {
    intelephense = {
      stubs = { "/Users/rikulaa/.config/composer/vendor/php-stubs", "bcmath", "bz2", "Core", "curl", "date", "dom", "fileinfo", "filter", "gd", "gettext", "hash", "iconv", "imap", "intl", "json", "libxml", "mbstring", "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "PDO", "pdo_mysql", "Phar", "readline", "regex", "session", "SimpleXML", "sockets", "sodium", "standard", "superglobals", "tokenizer", "xml", "xdebug", "xmlreader", "xmlwriter", "yaml", "zip", "zlib", "wordpress", "woocommerce", "wordpress-stubs", "woocommerce-stubs", "acf-pro-stubs", "wordpress-globals", "wp-cli-stubs", "genesis-stubs", "polylang-stubs"},
      files = {
        maxSize = 5000000;
      };
    };
  },
  on_attach = on_attach,
  cababilities = cababilities,
  flags = {
    debounce_text_changes = 150,
  },
  init_options = {
    -- storagePath = Optional absolute path to storage dir. Defaults to os.tmpdir().
    -- globalStoragePath = Optional absolute path to a global storage dir. Defaults to os.homedir().
    licenceKey = vim.fn.expand('~/.config/intelephense/licence.txt'),
    -- clearCache = Optional flag to clear server state. State can also be cleared by deleting {storagePath}/intelephense
    -- See https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#initialisation-options
  },
}
nvim_lsp.enable('intelephense')
-- nvim_lsp.enable('intelephense')

nvim_lsp['omnisharp'] = {
    -- on_attach = on_attach_omnisharp,
    on_attach = on_attach,
    cmd = { "OmniSharp" },

    settings = {
      FormattingOptions = {
        -- Enables support for reading code style, naming convention and analyzer
        -- settings from .editorconfig.
        EnableEditorConfigSupport = true,
        -- Specifies whether 'using' directives should be grouped and sorted during
        -- document formatting.
        OrganizeImports = true,
      },
      MsBuild = {
        -- If true, MSBuild project system will only load projects for files that
        -- were opened in the editor. This setting is useful for big C# codebases
        -- and allows for faster initialization of code navigation features only
        -- for projects that are relevant to code that is being edited. With this
        -- setting enabled OmniSharp may load fewer projects and may thus display
        -- incomplete reference lists for symbols.
        LoadProjectsOnDemand = nil,
      },
      RoslynExtensionsOptions = {
        -- Enables support for roslyn analyzers, code fixes and rulesets.
        EnableAnalyzersSupport = nil,
        -- Enables support for showing unimported types and unimported extension
        -- methods in completion lists. When committed, the appropriate using
        -- directive will be added at the top of the current file. This option can
        -- have a negative impact on initial completion responsiveness,
        -- particularly for the first few completion sessions after opening a
        -- solution.
        EnableImportCompletion = true,
        -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        -- true
        AnalyzeOpenDocumentsOnly = nil,
      },
      Sdk = {
        -- Specifies whether to include preview versions of the .NET SDK when
        -- determining which version to use for project loading.
        IncludePrereleases = true,
      },
    },
}
-- nvim_lsp.enable('omnisharp')

-- -- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  -- snippet = {
  --   expand = function(args)
  --     luasnip.lsp_expand(args.body)
  --   end,
  -- },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}



-- TODO: update to latest treesitter to use these
-- nvim_treesitter_text_objects_config = {
--   select = {
--     enable = true,
--     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--     keymaps = {
--       -- You can use the capture groups defined in textobjects.scm
--       ['aa'] = '@parameter.outer',
--       ['ia'] = '@parameter.inner',
--       ['af'] = '@function.outer',
--       ['if'] = '@function.inner',
--       ['ac'] = '@class.outer',
--       ['ic'] = '@class.inner',
--     },
--   },
--   move = {
--     enable = true,
--     set_jumps = true, -- whether to set jumps in the jumplist
--     goto_next_start = {
--       [']m'] = '@function.outer',
--       [']]'] = '@class.outer',
--     },
--     goto_next_end = {
--       [']M'] = '@function.outer',
--       [']['] = '@class.outer',
--     },
--     goto_previous_start = {
--       ['[m'] = '@function.outer',
--       ['[['] = '@class.outer',
--     },
--     goto_previous_end = {
--       ['[M'] = '@function.outer',
--       ['[]'] = '@class.outer',
--     },
--   },
--   swap = {
--     enable = true,
--     swap_next = {
--       ['<leader>a'] = '@parameter.inner',
--     },
--     swap_previous = {
--       ['<leader>A'] = '@parameter.inner',
--     },
--   },
-- }
-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'vimdoc', 'javascript', 'tsx', 'typescript', 'vim', 'php', 'markdown', 'elixir', 'heex', 'eex' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'php'},
  },
  indent = { 
    enable = true,
    disable = { 'php' },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
}

-- Enable autoclosing https://github.com/windwp/nvim-ts-autotag
require('nvim-ts-autotag').setup()

-- Setup autopairs
require("nvim-autopairs").setup {}

require("which-key").setup {}

require("exrc").setup({
  files = {
      ".nvimrc.lua",
      ".nvimrc",
  },
})

-- Formatter
require("conform").setup({
  formatters_by_ft = {
    -- Use a sub-list to run only the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
  },
})

-- #################
-- Personal settings
-- #################
local set = vim.opt

-- Default greprpg defaults to 'rg --vimgrep -uu' (which search almost everything)
if vim.fn.executable('rg') == 1 then
  set.grepprg= 'rg --vimgrep'
end


-- Open quickfix after searching
vim.cmd([[
    augroup BetterQuickFix
    autocmd!
    autocmd QuickFixCmdPost grep cwindow
    autocmd QuickFixCmdPost lgrep lwindow
    augroup END
]])

-- Highlight yanked text
vim.cmd([[
    augroup yanking
    au TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false}
    augroup END
]])
-- Tabs

vim.cmd([[
    augroup php
    au BufNewFile *.php execute 'normal O<?php' | normal j
    augroup END
]])

set.shiftwidth = 4 -- When indenting with >
set.expandtab = true

set.swapfile = false

-- for which-key
vim.o.timeoutlen = 500

vim.cmd.colorscheme('catppuccin-latte')
set.termguicolors = true
if vim.fn.has('mac') and vim.fn.system('defaults read -g AppleInterfaceStyle 2>/dev/null') == 'Dark\n' then
    vim.opt.background = 'dark'
else
    vim.opt.background = 'light'
end

-- UI
set.number = true
set.relativenumber = true
set.cursorline = true

-- Windows
set.splitbelow = true
set.splitright = true
set.wrap = false

-- Mouse
set.mouse = 'nvi'


-- Completion
set.completeopt ='menu,menuone,noselect'

-- Set <leader> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Mappings
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<CR>', {})
-- Use 'rg --files' because it seems to be the easiest way to get the most sensible list of files (e.g in git repository and not in git repository)
vim.keymap.set('n', '<leader>p', ":call fzf#run(fzf#wrap({'source': 'rg --files'}))<cr>", { desc = 'Search files'})
vim.keymap.set('n', '<leader>.',  ":call fzf#run(fzf#wrap({'source': 'rg --files'}))<cr>", { desc = 'Search files'})
vim.keymap.set('n', '<leader>,', '<cmd>Buffers<CR>', { desc = 'Buffers'})
-- vim.keymap.set('n', '<leader>e', '<cmd>Explore<CR>', { desc = 'Explore files'})
vim.keymap.set('n', '<leader>e', function()
  local is_netrw = vim.bo.filetype == 'netrw'
  if is_netrw then
    vim.cmd('Rexplore')
  else
    vim.cmd('Explore')
  end
end, { desc = 'Toggle file explorer' })

-- insert mode readline navigation
vim.keymap.set('i', '<C-A>', '<C-O>^', {})
vim.keymap.set('c', '<C-A>', '<Home>', {})
-- Make sure the original behaviour for <C-A> is still available
vim.keymap.set('c', '<C-X><C-A> ', '<C-A>', {})

-- Jump to end of line
vim.keymap.set('i', '<C-E>', '<C-O>$', {})
vim.keymap.set('c', '<C-E>', '<End>', {})
-- Move one word backward, forward
vim.keymap.set('i', '<M-b>', '<C-Left>', {})
vim.keymap.set('c', '<M-b>', '<C-Left>', {})
vim.keymap.set('i', '<M-f>', '<C-Right>', {})
vim.keymap.set('c', '<M-f>', '<C-Right>', {})
-- Move one character backward, forward
vim.keymap.set('i', '<C-b>', '<Left>', {})
vim.keymap.set('c', '<C-b>', '<Left>', {})
vim.keymap.set('i', '<C-f>', '<Right>', {})
vim.keymap.set('c', '<C-f>', '<Right>', {})

-- Move visual block
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', { desc = 'Move selection one line up'})
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move selection one line down'})

-- Easyaling visual block
vim.keymap.set('v', '<leader>=', ':EasyAlign<CR>', { desc = 'Easy align selection'})

-- window navigation
vim.keymap.set('n', '<leader>w', '<C-W>', { desc = 'Windows'})

-- navigation - tabs
vim.keymap.set('n', ']t', '<cmd>tabnext<CR>', {})
vim.keymap.set('n', '[t', '<cmd>tabprev<CR>', {})
vim.keymap.set('n', '<leader>1', '<cmd>tabfirst<cr>', {})
vim.keymap.set('n', '<leader>2', '2gt', {})
vim.keymap.set('n', '<leader>3', '3gt', {})
vim.keymap.set('n', '<leader>4', '4gt', {})
vim.keymap.set('n', '<leader>5', '5gt', {})
vim.keymap.set('n', '<leader>6', '6gt', {})
vim.keymap.set('n', '<leader>7', '7gt', {})
vim.keymap.set('n', '<leader>8', '8gt', {})
vim.keymap.set('n', '<leader>9', '<cmd>tablast<cr>', {})
-- TODO: 9 => should jump to last tab

-- nav - quickfix
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', {})
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', {})

-- nav - arglist
vim.keymap.set('n', ']a', '<cmd>next<CR>', {})
vim.keymap.set('n', '[a', '<cmd>prev<CR>', {})

-- File operations
vim.keymap.set('n', '<leader>fw', '<cmd>write<CR>', { desc = 'Write file (buffer)'})
vim.keymap.set('n', '<leader>fd', '<cmd>bdelete<CR>', { desc = 'Delete file (buffer)'})

-- Eeasier copy pasta
vim.keymap.set('n', '<leader>Y', '"*y', { desc = 'Copy to system clipboard' })
vim.keymap.set('v', '<leader>Y', '"*y', { desc = 'Copy to system clipboard'})
vim.keymap.set('n', '<leader>P', '"+p', { desc = 'Paste from system clipboard'})

-- 
vim.keymap.set('n', '<leader>ss', ':%s//g<Left><Left>', { desc = 'Substitute'})
-- Rsname last search
-- vim.keymap.set('n', '<leader>ss', ':%s///g<Left><Left>', { desc = 'Substitute last search pattern'})
-- vim.keymap.set('v', '<leader>ss', ':%s///g<Left><Left>', { desc = 'Substitute last search pattern'})
vim.keymap.set('v', '<leader>ss', ':s//g<Left><Left>', { desc = 'Substitute inside visual selection'})


-- cli
vim.keymap.set('n', '<leader>;', ':', {})

-- searching
vim.keymap.set('n', '<leader>/', ':silent grep! ""<Left>', { desc = 'Grep' })
vim.keymap.set('v', '<leader>/', 'y :let @/ = \'<C-r>\"\' | set hlsearch | silent grep! \'<C-R>"\' ', { desc = 'Grep (visual selection)' })
vim.keymap.set('n', '<leader>*', 'vawy :let @/ = \'<C-r>\"\' | set hlsearch | silent grep! <C-R>" <CR>', { desc = 'Grep (visual selection)' })
-- vim.keymap.set('n', 'n', 'nzz', { desc = '' })
-- vim.keymap.set('n', 'N', 'Nzz', { desc = '' })


-- Git
-- vim.keymap.set('n', '<leader>vs', '<cmd>tabnew | Git | only<CR>', { desc = 'Status'}) -- TODO: Would be nice to always jump to this window if it's available
vim.keymap.set('n', '<leader>vs', '<cmd>Git<CR>', { desc = 'Status'}) -- TODO: Would be nice to always jump to this window if it's available
vim.keymap.set('n', '<leader>va', '<cmd>Ga<CR>', { desc = 'Stage file'})
vim.keymap.set('n', '<leader>vb', '<cmd>Git blame<CR>', { desc = 'Blame'})
vim.keymap.set('n', '<leader>vhs', '<cmd>GitGutterStageHunk<CR>', { desc = 'Stage hunk'})
vim.keymap.set('n', '<leader>vrp', '<cmd>!git push<CR>', { desc = 'Git push'})

-- Open
vim.keymap.set('n', '<leader>ov', '<cmd>e $MYVIMRC<CR>', { desc = 'Open vimrc'})
vim.keymap.set('n', '<leader>oc', '<cmd>copen<CR>', { desc = 'Open quickfix'})
vim.keymap.set('n', '<leader>ot', '<cmd>tabnew<CR>', { desc = 'Open new tab'})

vim.keymap.set('t', '<Esc>', '<C-c>', { desc = 'Exit terminal mode'})
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode'})
vim.keymap.set('t', '<Esc>', '<C-c>', { desc = 'Exit terminal mode'})
vim.keymap.set('t', '<C-v><Esc>', '<Esc>', { desc = 'Send escape to terminal'})
-- tnoremap <Esc> <C-\><C-n>
-- tnoremap <M-[> <Esc>
-- tnoremap <C-v><Esc> <Esc>
--
-- Formatting
vim.keymap.set('n', '<leader>lF', 'gg0gqG<C-O>', { desc = 'Format whole document with formatprq'})
vim.keymap.set('v', '<leader>lF', 'gq', { desc = 'Format selection with formatprq'})

-- Commands
vim.api.nvim_create_user_command('Ga', 'silent !git add "%"', {})
vim.api.nvim_create_user_command('Rm', 'call system(["rm", expand("%")]) | bd!', {})

vim.api.nvim_create_user_command('Bdall', 'silent! :%bdelete!', {})

vim.api.nvim_create_user_command('CopyName', ':let @+ = expand(\'%\')', {})

vim.api.nvim_create_user_command(
  'Run',
  function(params)
      -- TODO: detect if there is already a terminal open and use that instead
      if params['args'] == '' then
      -- TODO: customizable cmd by filetype,environment etc
        vim.cmd('split | terminal!' .. vim.o.filetype .. ' ' .. vim.fn.expand('%'))
        vim.cmd('normal GA')
    else
        vim.cmd('split | terminal!' .. params['args'])
        vim.cmd('normal GA')
      end
  end,
  {nargs='*'}
)


-- TODO: this has to be window specific, does it?
local Filelist = {
    direction = 1,
    index = 0,
    files = {},
    previous = function()
        Filelist.index = Filelist.index - 1
        file = Filelist.files[Filelist.index]
        vim.cmd('e ' .. file)
    end,
    next = function()
        Filelist.index = Filelist.index + 1
        file = Filelist.files[Filelist.index]
        vim.cmd('e ' .. file)
    end,
    push = function(file)
      if string.len(file) > 0 then
        last_file = Filelist.files[#Filelist.files]
        if last_file ~= file then
          print(file)
          Filelist.index = #Filelist.files + 1
          table.insert(Filelist.files, file)
        end
      end
    end,
}
_G.Filelist = Filelist
vim.api.nvim_create_user_command(
  'PreviousBuffer',
  function(params)
      Filelist.previous()
  end,
  {nargs='*'}
)
vim.api.nvim_create_user_command(
  'NextBuffer',
  function(params)
      Filelist.next()
  end,
  {nargs='*'}
)
vim.cmd([[
    augroup quickfix
    autocmd!
    autocmd BufEnter * lua Filelist.push(vim.fn.expand('%'))
    augroup END
]])


-- sharp
vim.g["fsharp#fsautocomplete_command"] = { "dotnet", "fsautocomplete", "--background-service-enabled" }



