-- Plug ----------------------------------------------------------------
local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('sainnhe/everforest')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-treesitter/nvim-treesitter')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')
Plug('nvimtools/none-ls.nvim')
Plug('Raimondi/delimitMate')
-- neotree reqs
Plug('nvim-lua/plenary.nvim')
Plug('nvim-tree/nvim-web-devicons')
Plug('MunifTanjim/nui.nvim')
Plug('nvim-neo-tree/neo-tree.nvim')
Plug('nvim-telescope/telescope-ui-select.nvim')
-- R nvim
Plug('jamespeapen/Nvim-R')

vim.call('plug#end')

-- Theme evergarden --------------------------------------------------
vim.cmd.colorscheme "everforest"

-- global settings -------------------------------------------------
vim.wo.number = true               -- Enable line numbers

-- telescope keymaps ----------------------------------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})

-- This is your opts table
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")


-- neotree keymaps ----------------------------------------------
vim.keymap.set('n', '<C-e>', ':Neotree toggle<CR>')
vim.api.nvim_set_keymap('i', '<Tab><Tab>', '<C-x><C-o>', { silent = true })

-- Treesitter ----------------------------------------------------
local config = require("nvim-treesitter.configs")
config.setup({
	auto_install = true,
	highlight = {enable = true},
	indent = {enable = true}
})

-- LSP ----------------------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup {
	auto_install = true
}

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({})
lspconfig.r_language_server.setup({})
lspconfig.jedi_language_server.setup({})

-- null ls
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
})

