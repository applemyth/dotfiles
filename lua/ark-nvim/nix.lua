vim.g.mapleader = ";"
vim.g.maplocalleader = "\\"

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = vim.api.nvim_create_augroup("BladeFiletypeRelated", { clear = true }),
  pattern = "*.blade.php",
  command = "set filetype=blade",
})

vim.cmd.colorscheme("ayu")

require("nvim-tree").setup({
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
})

vim.keymap.set("n", "<C-b>", "<cmd>NvimTreeFindFileToggle<CR>", { silent = true })

require("lualine").setup({
  sections = {
    lualine_x = {
      {
        function()
          return string.format("%d/%d", vim.fn.bufnr(), #vim.fn.getbufinfo({ buflisted = 1 }))
        end,
        icon = "buf",
      },
    },
  },
})

vim.keymap.set("n", "<leader>Gs", "<cmd>Git<cr>", { desc = "Fugitive: Git status" })
vim.keymap.set("n", "<leader>Gd", "<cmd>Gvdiffsplit<cr>", { desc = "Fugitive: Diff against index/HEAD" })
vim.keymap.set("n", "<leader>Gb", "<cmd>Git blame<cr>", { desc = "Fugitive: Git blame" })
vim.keymap.set("n", "<leader>Gc", "<cmd>Git commit<cr>", { desc = "Fugitive: Commit" })
vim.keymap.set("n", "<leader>Gp", "<cmd>Git push<cr>", { desc = "Fugitive: Push" })
vim.keymap.set("n", "<leader>Gl", "<cmd>Git pull<cr>", { desc = "Fugitive: Pull" })

local cmp = require("cmp")
local cmp_lsp = require("cmp_nvim_lsp")

local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  cmp_lsp.default_capabilities()
)

require("fidget").setup({})

vim.lsp.config("*", {
  capabilities = capabilities,
})

for _, server in ipairs({
  "astro",
  "html",
  "intelephense",
  "pyright",
  "tailwindcss",
  "texlab",
  "vimls",
}) do
  vim.lsp.config(server, {
    single_file_support = true,
  })
end

vim.lsp.config("lua_ls", {
  diagnostics = { disable = { "missing-fields", "incomplete-signature-doc" } },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config("denols", {
  root_markers = { "deno.json", "deno.jsonc" },
})

vim.lsp.config("ts_ls", {
  root_markers = { "package.json" },
  single_file_support = false,
})

vim.lsp.enable({
  "astro",
  "html",
  "intelephense",
  "pyright",
  "tailwindcss",
  "texlab",
  "vimls",
  "lua_ls",
  "denols",
  "ts_ls",
})

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-Space>"] = cmp.mapping.confirm({ select = true }),
    ["<C-y>"] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

vim.diagnostic.config({
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = true,
    header = "",
    prefix = "",
  },
})

require("telescope").setup({
  defaults = {
    hidden = true,
    no_ignore = true,
  },
  extensions = {
    undo = {},
  },
})

require("telescope").load_extension("undo")

local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", function()
  telescope.find_files({ hidden = true, no_ignore = true })
end)
vim.keymap.set("n", "<leader><Space>", telescope.oldfiles)
vim.keymap.set("n", "<leader>fg", telescope.live_grep)
vim.keymap.set("n", "<leader>fh", telescope.help_tags)
vim.keymap.set("n", "<leader>fb", telescope.buffers)
vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "undo history" })

require("spectre").setup()
vim.keymap.set("n", "<leader>S", function()
  require("spectre").open()
end, { desc = "Spectre: Search in project" })
vim.keymap.set("n", "<leader>rw", function()
  require("spectre").open_visual({ select_word = true })
end, { desc = "Spectre: Replace current word" })

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ArkTreesitterStart", { clear = true }),
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})

require("zen-mode").setup({
  window = {
    backdrop = 1,
    width = 80,
    options = {},
  },
  on_open = function()
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.number = false
    vim.wo.rnu = false
    vim.opt.colorcolumn = "0"
    cmp.setup.buffer({ enabled = false })
  end,
  on_close = function()
    vim.wo.wrap = true
    vim.wo.linebreak = false
    vim.wo.number = true
    vim.wo.rnu = true
    cmp.setup.buffer({ enabled = true })
  end,
})

vim.keymap.set("n", "<leader>zz", function()
  require("zen-mode").toggle()
end)
