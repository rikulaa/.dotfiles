local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'

  use 'nvim-treesitter/nvim-treesitter'
  use 'windwp/nvim-ts-autotag' 

  use "windwp/nvim-autopairs"
  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
      requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Lua
  use "folke/which-key.nvim"

  use {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      tag = "v1.*",
      -- install jsregexp (optional!:).
      run = "make install_jsregexp"
  }

  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'junegunn/vim-easy-align'
  use 'tpope/vim-abolish'
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use 'editorconfig/editorconfig-vim'

  use { "catppuccin/nvim", as = "catppuccin" }
  use 'morhetz/gruvbox'
  use 'arcticicestudio/nord-vim'
end)

local set = vim.opt

-- if executable('rg')
if vim.fn.executable('rg') == 1 then
    set.grepprg= 'rg --vimgrep'
end


-- Open quickfix after searching
vim.cmd([[
    augroup quickfix
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

set.shiftwidth = 4 -- When indenting with >
set.expandtab = true

-- for which-key
vim.o.timeoutlen = 500

-- Colors
-- vim.cmd.colorscheme('nord')
-- set.background = 'light'


vim.cmd.colorscheme('catppuccin-latte')
-- set.background = 'light'
set.termguicolors = true

-- UI
set.number = true

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
vim.keymap.set('n', '<leader>p', '<cmd>Telescope find_files<CR>', { desc = 'Search files'})
vim.keymap.set('n', '<leader>.', '<cmd>Telescope find_files<CR>', { desc = 'Search files'})
vim.keymap.set('n', '<leader>,', '<cmd>Telescope buffers<CR>', { desc = 'Buffers'})
vim.keymap.set('n', '<leader>e', '<cmd>Explore<CR>', { desc = 'Explore files'})

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

-- window navigation
vim.keymap.set('n', '<leader>w', '<C-W>', { desc = 'Windows'})

-- navigation
vim.keymap.set('n', ']t', '<cmd>tabnext<CR>', {})
vim.keymap.set('n', '[t', '<cmd>tabprev<CR>', {})

-- nav - buffers
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', {})
vim.keymap.set('n', '[b', '<cmd>bprev<CR>', {})

-- nav - quickfix
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', {})
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', {})

-- nav - arglist
vim.keymap.set('n', ']a', '<cmd>next<CR>', {})
vim.keymap.set('n', '[a', '<cmd>prev<CR>', {})

-- File operations
vim.keymap.set('n', '<leader>fw', '<cmd>write<CR>', { desc = 'Write file'})

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
vim.keymap.set('n', '<leader>/', ':silent grep! ', { desc = 'Grep' })
vim.keymap.set('v', '<leader>/', 'y :let @/ = \'<C-r>\"\' | set hlsearch | silent grep! <C-R>" ', { desc = 'Grep (visual selection)' })


-- Git
vim.keymap.set('n', '<leader>vs', '<cmd>Git<CR>', { desc = 'Git'})
vim.keymap.set('n', '<leader>vhs', '<cmd>GitGutterStageHunk<CR>', { desc = 'Stage hunk'})
vim.keymap.set('n', '<leader>vrp', '<cmd>!git push<CR>', { desc = 'Git push'})

-- Open
vim.keymap.set('n', '<leader>ov', '<cmd>e $MYVIMRC<CR>', { desc = 'Open vimrc'})


-- Commands
vim.api.nvim_create_user_command('Ga', 'silent !git add "%"', {})



-- LSP setup
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<F3>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<F5>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  --buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('v', '<leader>lf', ':lua vim.lsp.buf.range_formatting()<CR>', opts)
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
local servers = { 'pylsp', 'tsserver','vuels', 'intelephense', 'astro' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    cababilities = cababilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
end

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
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}


vim.lsp.set_log_level("debug")


-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'javascript', 'tsx', 'typescript', 'help', 'vim', 'php', 'markdown' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Enable autoclosing https://github.com/windwp/nvim-ts-autotag
require('nvim-ts-autotag').setup()

-- Setup autopairs
require("nvim-autopairs").setup {}

require("which-key").setup {}

