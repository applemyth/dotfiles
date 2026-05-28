----Define global variable to prevent lsp flag
_G.vim = _G.vim or {}
----Basic Variables
local opts = { noremap=true, silent=true }

---- GENERAL NVIM
vim.cmd('syntax enable')
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.linebreak = true
vim.o.ignorecase = true
vim.o.smartcase = true
-- vim.o.laststatus = 0
---- tabs 
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
--
---- MAIN MAPPING
--
vim.g.mapleader = ';'
-- movements/general
vim.api.nvim_set_keymap('', 'j', 'gj', {noremap = true})
vim.api.nvim_set_keymap('', 'k', 'gk', {noremap = true})

vim.api.nvim_set_keymap('', '<leader>q', ':q<CR>', {noremap = true})
vim.api.nvim_set_keymap('', '<leader>Q', ':qa<CR>', {noremap = true})
vim.api.nvim_set_keymap('', '<leader>w', ':w<CR>', {noremap = true})

vim.api.nvim_set_keymap('i', '<leader><leader>', '<Esc>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader><leader>', '<Esc>', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader><leader>', '<Esc>', {noremap = true})

-- clear search
vim.keymap.set('n', '<leader>/', ':nohlsearch<CR>')

-- movements in insert mode
vim.api.nvim_set_keymap('i', '<C-j>', '<C-o>gj', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-k>', '<C-o>gk', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', {noremap = true})
-- escape when adding new line above and below to stay in normal mode
vim.api.nvim_set_keymap('n', 'o', 'o<Esc>', {noremap = true})
vim.api.nvim_set_keymap('n', 'O', 'O<Esc>', {noremap = true})
-- auto indent according to syntax 
vim.keymap.set("n", "<leader>=", "gg=G``")

-- never used
-- TODO delete
-- add space in normal mode
--vim.api.nvim_set_keymap('n', '<leader><Space>', 'i<Space><Esc>', { noremap = true })

-- yonk to buffer
vim.api.nvim_set_keymap('v', 'Y', '"+y', {noremap = true, silent = true})

-- buffer stuff
-- buffer commands
vim.api.nvim_set_keymap('n', '<leader>n', ':bn<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>p', ':bp<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', {noremap = true})

-- never used
-- TODO delete
--vim.api.nvim_set_keymap('n', '<leader>bn', ':enew<CR>', {noremap = true})
--vim.api.nvim_set_keymap('n', '<leader>bc', ':close<CR>', {noremap = true})
--

-- buffer window switch
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
-- buffer increase/decrease width

vim.api.nvim_set_keymap('n', '+', ':vertical resize +2<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '_', ':vertical resize -2<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>t', ':cd %:p:h<CR>:terminal<CR>', { noremap = true, silent = true })

-- never used so commented
-- TODO delete
--vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
--vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)

-- remapped split didn't, saved for later if needed as reminder.
vim.api.nvim_set_keymap('n', '<leader>bs', ':vsplit<CR>', {noremap = true})
--vim.api.nvim_set_keymap('n', '<leader>bs', vim.cmd('vsplit term://%:p:h//bash'), {noremap = true})
--vim.api.nvim_set_keymap('n', '<leader>bh', ':split<CR>', {noremap = true})

-- LSP stuff: Defs, Diagnostics, etc..
vim.keymap.set('n','K', function() vim.diagnostic.open_float(nil, {focusable = true}) end, {})
vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', 'tD', vim.lsp.buf.type_definition, opts)

vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, opts)
--
---- MAIN MAPPING
--


-- close and open buffers function

vim.api.nvim_exec([[
  function! CloseAndGoNextBuffer()
    let previous_buffer = bufnr('#')
    let buffer_count = len(getbufinfo({'buflisted':1}))
    if buffer_count > 1
      execute 'bn'
      execute 'bdelete #'
    else
      q
    endif
  endfunction
]], false)
vim.api.nvim_set_keymap('n', '<leader>x', ':call CloseAndGoNextBuffer()<CR>', {noremap = true})

--vim.api.nvim_exec([[
--  function! CloseAndGoNextBuffer()
--    let l:next_buffer = bufnr('#')
--    let buffer_count = len(getbufinfo())
--    if buffer_count > 1
--      execute 'buffer' l:next_buffer
--      execute 'bdelete #'
--    else
--      q
--    endif
--  endfunction
--]], false)
--vim.api.nvim_set_keymap('n', '<leader>x', ':call CloseAndGoNextBuffer()<CR>', {noremap = true})




---- TRUE ZEN KEYBINDINGS
-- plugin/keybindings.lua
--vim.api.nvim_set_keymap("n", "<leader>zm", ":TZAtaraxis<CR>", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<leader>za", ":TZMinimalist<CR>", { noremap = true, silent = true })


---- TRUE-ZEN 
--vim.api.nvim_set_keymap("n", "<leader>zm", ":TZAtaraxis<CR>", {})

--api.nvim_set_keymap("n", "<leader>zn", ":TZNarrow<CR>", {})
--api.nvim_set_keymap("v", "<leader>zn", ":'<,'>TZNarrow<CR>", {})
--api.nvim_set_keymap("n", "<leader>zf", ":TZFocus<CR>", {})
--api.nvim_set_keymap("n", "<leader>zm", ":TZMinimalist<CR>", {})
--api.nvim_set_keymap("n", "<leader>za", ":TZAtaraxis<CR>", {})








---- lsp keymaps
--
--
--
--
-- keymaps for that exist in the plugin_config/lspconfig.lua file
--vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
--vim.keymap.set('n', '<leader›ca', vim.lsp.buf.code_action, {})
--vim.keymap.set('h', 'gd', vim.lsp.buf.definition, {})
--vim.keymap.set ('n', 'gi', vim.lsp.buf.implementation, {})
--vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
--vim.keymap.set('n','K', vim.lsp.buf.hover, {})

---- treesitter keymaps
-- see above for require local builtin = require ('telescope.builtin')
--vim.keymap.set('n', '<Space>ff', builtin.find_files, {})
--vim.keymap.set('n', '<Space><Space>', builtin.oldfiles, {})
--vim.keymap.set('n', '<Space>fg' , builtin.live_grep, {})
--vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})

---- split screen movements
--vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', {})
--vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', {})
--vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', {})
--vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', {})

---- Define functions in Vimscript
--vim.cmd [[
--  function! GoyoEnter()
--    set noshowmode
--    set noruler
--    set laststatus=0
--    set noshowcmd
--  endfunction
--
--  function! GoyoLeave()
--    set showmode
--    set ruler
--    set laststatus=2
--    set showcmd
--  endfunction
--]]
--
---- Set up autocommands in Lua
--vim.cmd [[
--  augroup GoyoSetup
--    autocmd!
--    autocmd User GoyoEnter call GoyoEnter()
--    autocmd User GoyoLeave call GoyoLeave()
--  augroup END
--]]
--

