vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.wo.number = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x'
    },
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {
        'hrsh7th/nvim-cmp',
    },
    {'L3MON4D3/LuaSnip'},
    {'tpope/vim-fugitive'},
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        config = function()
            require("neo-tree").setup {
                follow_current_file = { enabled = true },
                filesystem = {
                    filtered_items = {
                        visible = true,
                        hide_dotfiles = false,
                        hide_gitignored = false
                    }
                }
	    }
        end,
	dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper'
            }
        end,
        dependencies = {'nvim-tree/nvim-web-devicons'}
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000
    },
    {
        'p00f/cphelper.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {"vim-airline/vim-airline"},
    {
        'windwp/nvim-autopairs',
         event = "InsertEnter",
         config = true
    }
})

vim.cmd.colorscheme "catppuccin"

local lsp_zero = require("lsp-zero")
lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
end)

require("lspconfig").gopls.setup({})
require("lspconfig").rust_analyzer.setup({})
require("lspconfig").pyright.setup({})
require("lspconfig").cmake.setup({})
require("lspconfig").clangd.setup({})

local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
	if not entry then
	  cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
	end
	cmp.confirm()
      else
        fallback()
      end
    end, {"i","s","c",}),
  }
})

