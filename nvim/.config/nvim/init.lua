vim.cmd.packadd("cfilter") -- Filter cuickfix with /pat/

-- #################
-- Plugin settings
-- #################
local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'  -- Package manager
  use 'neovim/nvim-lspconfig'   -- Configurations for Nvim LSP
  use 'hrsh7th/nvim-cmp'        -- autocomplete popup menu
  use 'hrsh7th/cmp-nvim-lsp'    -- lsp source for cmp
  use 'stevearc/conform.nvim'   -- Formatting
  use {
    "nvim-treesitter/nvim-treesitter",
    branch ="main",
    run = ":TSUpdate",
  }
  use 'nelsyeung/twig.vim'      -- support for twig syntax higlights
  use 'windwp/nvim-ts-autotag'  -- Use treesitter to autoclose and autorename html tag
  use "junegunn/fzf"
  use "junegunn/fzf.vim"
  use "windwp/nvim-autopairs"   -- Insert matching brackets, e.g. (|), {|}
  use 'mtikekar/nvim-send-to-term'
  use "folke/which-key.nvim"
  use "Hoffs/omnisharp-extended-lsp.nvim"
  -- TODO: Can you configure just omnisharp ?
  -- use 'ionide/Ionide-vim'
  use 'tpope/vim-surround'
  use 'junegunn/vim-easy-align' -- align
  use 'tpope/vim-abolish'       -- Convert between cases -> camelCase -> snake_case
  use 'tpope/vim-fugitive'      -- Git porcelain
  use 'airblade/vim-gitgutter'  -- Show git diff signatures in "gutter"
  use { "catppuccin/nvim", as = "catppuccin" }
end)

-- LSP setup
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See help: lsp.txt, vim.lsp.*
  -- Some keymaps are created unconditionally when Nvim starts:
  -- - "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
  -- - "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
  -- - "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
  -- - "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
  -- - "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
  -- - CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|
	-- "k" is mapped in Normal mode to "Hover"

  buf_set_keymap('n', '<X2Mouse>', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Jump to definition' })
  buf_set_keymap('n', '<X1Mouse>', '<C-O>', { desc = 'Go back' })
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('i', '<C-S>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<F3>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('i', '<F3>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- Default mapping "grn"
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- Default mapping "gra"
  buf_set_keymap('n', '<F5>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

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
  on_attach(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- Override some mappings for omnisharp (jumps to source definitions)
  buf_set_keymap('n', '<X2Mouse>', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Jump to definition' })
  buf_set_keymap('n', 'gD', '<cmd>lua require("omnisharp_extended").lsp_type_definition()<cr>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua require("omnisharp_extended").lsp_definition()<cr>', opts)
  buf_set_keymap('n', '<leader>li', '<cmd>lua require("omnisharp_extended").lsp_implementation()<cr>', opts)
  buf_set_keymap('n', 'grr', '<cmd>lua require("omnisharp_extended").lsp_references()<cr>', opts)
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
-- vue_ls needs vtsls for typescript support
-- remove eslint and vuels
-- local servers = { 'pylsp', 'ts_ls', 'astro', 'svelte', 'eslint', 'gopls', 'html' , 'jsonls', 'vls', 'omnisharp' }
--
local servers = { 'pylsp', 'eslint', 'astro', 'svelte', 'gopls', 'html' , 'jsonls', 'biome'}
for _, lsp in ipairs(servers) do
  vim.lsp.config[lsp] = {
    on_attach = on_attach,
    cababilities = cababilities,
    flags = {
      debounce_text_changes = 150,
    },
  }
  vim.lsp.enable(lsp)

end

-- ts_ls's default root_dir walks up to the nearest package-manager lock file (or .git),
-- which in a pnpm monorepo is the workspace root. `typescript` is never resolvable from
-- there (nothing at the root depends on it directly), so typescript-language-server falls
-- back to a global/bundled tsserver that can resolve package `exports` maps differently
-- than each app's local TypeScript does. Prefer the nearest tsconfig.json/jsconfig.json
-- instead, so it roots the same way `tsc` itself does.
vim.lsp.config['ts_ls'] = {
  on_attach = on_attach,
  cababilities = cababilities,
  flags = {
    debounce_text_changes = 150,
  },
  root_dir = function(bufnr, on_dir)
    local project_root = vim.fs.root(bufnr, { 'tsconfig.json', 'jsconfig.json' })
      or vim.fs.root(bufnr, { 'package.json', '.git' })
    on_dir(project_root or vim.fn.getcwd())
  end,
}
vim.lsp.enable('ts_ls')


vim.lsp.config('vue_ls', {
  init_options = {
    typescript = {
      tsdk = vim.fn.expand '$PWD/.fnm/node-versions/v26.5.1/installation/lib/node_modules/typescript'
    }
  }
})

-- vue_ls needs vtsls for typescript support in vue files
local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
-- TODO: use envrc to add path to bin
local vue_language_server_path = vim.fn.expand '$PWD/.fnm/node-versions/v26.5.1/installation/lib/node_modules/@vue/language-server'

local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}
vim.lsp.config['vtsls'] = {
  on_attach = on_attach,
  cababilities = cababilities,
  flags = {
    debounce_text_changes = 150,
  },
   settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = tsserver_filetypes,
}
vim.lsp.enable('vtsls')

vim.lsp.config['elixirls'] = {
  on_attach = on_attach,
  cababilities = cababilities,
  cmd = {'elixir-ls'},
  flags = {
    debounce_text_changes = 150,
  },
}
vim.lsp.enable('elixirls')

vim.lsp.config['intelephense'] = {
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
    licenceKey = vim.fn.expand('~/.config/intelephense/licence.txt'),
  },
}
vim.lsp.enable('intelephense')

vim.lsp.config('omnisharp', {
  on_attach = on_attach_omnisharp,
})
vim.lsp.enable('omnisharp')

-- fsautocomplete
vim.lsp.config['fsautocomplete'] = {
  on_attach = on_attach,
  cababilities = cababilities,
  cmd = {"dotnet", "fsautocomplete", "--background-service-enabled" },
  flags = {
    debounce_text_changes = 150,
  },
}
vim.lsp.enable('fsautocomplete')
vim.g["fsharp#fsautocomplete_command"] = { "dotnet", "fsautocomplete", "--background-service-enabled" }


-- Harper (local offline "grammarly")
vim.lsp.config['harper'] = {
    cmd = { 'harper-ls', '--stdio' },
    filetypes = { 'markdown', 'text', 'tex', 'typst', 'gitcommit' }
}
vim.lsp.enable('harper')

-- -- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
  },
  sources = {
    { name = 'nvim_lsp' },
  },
}


require('nvim-treesitter').install {'vimdoc', 'javascript', 'tsx', 'typescript', 'vue', 'vim', 'php', 'markdown', 'elixir', 'heex', 'eex' }

-- Enable autoclosing https://github.com/windwp/nvim-ts-autotag
require('nvim-ts-autotag').setup()

-- Setup autopairs
require("nvim-autopairs").setup {}

require("which-key").setup {}

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

-- set.shiftwidth = 4 -- When indenting with >
-- set.expandtab = true

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

-- Mouse support for: 'normal', 'visual' and 'insert' modes.
-- Command-line mode does not deliberately support mouse because enables tmux mouse passthrough 
set.mouse = 'nvi'

-- Completion
set.completeopt ='menu,menuone,noselect'

-- Set <leader> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Mappings

-- Clear out search highlights with escape
vim.keymap.set('n', '<esc>', '<cmd>nohlsearch<CR>', {})
-- Use 'rg --files' because it seems to be the easiest way to get the most sensible list of files (e.g in git repository and not in git repository)
vim.keymap.set('n', '<leader>p', ":call fzf#run(fzf#wrap({'source': 'rg --files'}))<cr>", { desc = 'Search files'})
vim.keymap.set('n', '<leader>.',  ":call fzf#run(fzf#wrap({'source': 'rg --files'}))<cr>", { desc = 'Search files'})
vim.keymap.set('n', '<leader>,', '<cmd>Buffers<CR>', { desc = 'Buffers'})

-- "Explore" files
-- If we are already in netrw-buffer, we need to call "Rexplore" (Return to Explorer) instead of "Explore"
vim.keymap.set('n', '<leader>e', function()
  local is_netrw = vim.bo.filetype == 'netrw'
  if is_netrw then
    vim.cmd('Rexplore')
  else
    vim.cmd('Explore')
  end
end, { desc = 'Toggle file explorer' })

-- insert mode readline (like) navigation
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

-- Move visual block (up/down)
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv', { desc = 'Move selection one line up'})
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv', { desc = 'Move selection one line down'})

-- Move visual block (left/right)
vim.keymap.set('v', '<', '<gv', { desc = 'Decrease indent for selection'})
vim.keymap.set('v', '>', '>gv', { desc = 'Indent selection'})

-- Easyaling visual block
vim.keymap.set('v', '<leader>=', ':EasyAlign<CR>', { desc = 'Easy align selection'})

-- Window navigation. <leader>w as a additional prefix.
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

-- Substitute shorthand
vim.keymap.set('n', '<leader>ss', ':%s//g<Left><Left>', { desc = 'Substitute'})
vim.keymap.set('n', 'gss', ':%s//g<Left><Left>', { desc = 'Substitute'})

-- Substitute inside visual selection
vim.keymap.set('v', '<leader>ss', ':s//g<Left><Left>', { desc = 'Substitute inside visual selection'})

-- cli
vim.keymap.set('n', '<leader>;', ':', {})

-- searching
vim.keymap.set('n', '<leader>/', ':silent grep! ', { desc = 'Grep' })
vim.keymap.set('v', '<leader>/', 'y :let @/ = \'<C-r>\"\' | set hlsearch | silent grep! \'<C-R>"\' ', { desc = 'Grep (visual selection)' })
vim.keymap.set('n', '<leader>*', 'vawy :let @/ = \'<C-r>\"\' | set hlsearch | silent grep! <C-R>" <CR>', { desc = 'Grep (visual selection)' })


-- Git
-- vim.keymap.set('n', '<leader>vs', '<cmd>tabnew | Git | only<CR>', { desc = 'Status'}) -- TODO: Would be nice to always jump to this window if it's available
vim.keymap.set('n', '<leader>vs', '<cmd>Git<CR>', { desc = 'Status'})
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

-- Formatting
vim.keymap.set('n', '<leader>lF', 'gg0gqG<C-O>', { desc = 'Format whole document with formatprq'})
vim.keymap.set('v', '<leader>lF', 'gq', { desc = 'Format selection with formatprq'})

-- Commands
vim.api.nvim_create_user_command('Ga', 'Git add %', {})
vim.api.nvim_create_user_command('Rm', 'call system(["rm", expand("%")]) | bd!', {})

vim.api.nvim_create_user_command('Bdall', 'silent! :%bdelete!', {})

vim.api.nvim_create_user_command('CopyName', ':let @+ = expand(\'%\')', {})

-- Edit current filetype's plugin file
vim.api.nvim_create_user_command('Eft', function () vim.cmd(':execute "e ~/.config/nvim/after/ftplugin/".&filetype.".lua"') end, {})

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


vim.cmd([[iabbrev coauthclaude Co-Authored-By: Claude <noreply@anthropic.com>]])


-- NOTES
-- To replace text by piping to shell inside insert mode (after "c") you can press <C-R>=system(['the-commadn', @"])
