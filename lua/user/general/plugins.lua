local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}


-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim"   -- Have packer manage itself
  use "nvim-lua/popup.nvim"      -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"    -- Useful lua functions used ny lots of plugins
  --use "scrooloose/nerdtree" -- Tree Directory used for opening files
  use "scrooloose/nerdcommenter" -- commenter

  -- Theme
  use "joshdick/onedark.vim"
  use "folke/tokyonight.nvim"

  --use "Xuyuanp/nerdtree-git-plugin" -- show nerdtree git status
  use "nvim-tree/nvim-tree.lua"   -- show nerdtree git status
  use "nvim-tree/nvim-web-devicons"
  use "easymotion/vim-easymotion" -- Easier navigation


  -- cmp plugins
  use {
    "hrsh7th/nvim-cmp", -- The completion plugin
    commit = '7e348da6e5085ac447144a2ef4b637220ba27209'
  }

  use "hrsh7th/cmp-buffer"       -- buffer completions
  use "hrsh7th/cmp-path"         -- path completions
  use "hrsh7th/cmp-cmdline"      -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip"             --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins

  -- lsp
  use "neovim/nvim-lspconfig"             -- enable LSP
  use "williamboman/mason.nvim"           -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer
  use "RRethy/vim-illuminate"
  use 'jose-elias-alvarez/null-ls.nvim'   -- LSP diagnostics and code actions
  use "hashivim/vim-terraform"

  -- Telescope

  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Tree Sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- debugger
  use "mfussenegger/nvim-dap"
  use "mfussenegger/nvim-dap-python"
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }


  -- Airline

  use "vim-airline/vim-airline"
  use "vim-airline/vim-airline-themes"

  use "lewis6991/gitsigns.nvim"
  use "windwp/nvim-autopairs"
  use {
    "CopilotC-Nvim/CopilotChat.nvim",
    requires = {
      { "zbirenbaum/copilot.lua" },                     -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log, and async functions
    },
    run = "make tiktoken",                          -- Only on MacOS or Linux
    config = function()
      -- See Configuration section for options
    end
  } --use "github/copilot.vim"
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  }
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'pwntester/octo.nvim',
    commit = 'eaa193c92dd2caea6d7dea51531f6bfc0f5c2c30',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require "octo".setup()
    end
  }
  use 'tpope/vim-fugitive'

  use {
    'scalameta/nvim-metals',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    ft = { 'scala', 'sbt', 'java' },
    config = function()
      local metals_config = require('metals').bare_config()

      metals_config.on_attach = function(client, bufnr)
        local map = vim.api.nvim_buf_set_keymap
        local opts = { noremap = true, silent = true }
        map(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        map(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        map(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        map(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
        map(bufnr, 'n', 'gds', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
        map(bufnr, 'n', 'gws', '<Cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
        map(bufnr, 'n', '<leader>cl', '<Cmd>lua vim.lsp.codelens.run()<CR>', opts)
        map(bufnr, 'n', '<leader>sh', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        map(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
        map(bufnr, 'n', '<leader>f', '<Cmd>lua vim.lsp.buf.format()<CR>', opts)
        map(bufnr, 'n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        map(bufnr, 'n', '<leader>ws', '<Cmd>lua require("metals").hover_worksheet()<CR>', opts)
        map(bufnr, 'n', '<leader>aw', '<Cmd>lua vim.diagnostic.setqflist({ severity = "W" })<CR>', opts)
        map(bufnr, 'n', '<leader>d', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)
        map(bufnr, 'n', '[c', '<Cmd>lua vim.diagnostic.goto_prev({ wrap = false })<CR>', opts)
        map(bufnr, 'n', ']c', '<Cmd>lua vim.diagnostic.goto_next({ wrap = false })<CR>', opts)

        -- DAP mappings
        map(bufnr, 'n', '<leader>dc', '<Cmd>lua require("dap").continue()<CR>', opts)
        map(bufnr, 'n', '<leader>dr', '<Cmd>lua require("dap").repl.toggle()<CR>', opts)
        map(bufnr, 'n', '<leader>dK', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', opts)
        map(bufnr, 'n', '<leader>dt', '<Cmd>lua require("dap").toggle_breakpoint()<CR>', opts)
        map(bufnr, 'n', '<leader>dso', '<Cmd>lua require("dap").step_over()<CR>', opts)
        map(bufnr, 'n', '<leader>dsi', '<Cmd>lua require("dap").step_into()<CR>', opts)
        map(bufnr, 'n', '<leader>dl', '<Cmd>lua require("dap").run_last()<CR>', opts)
      end

      local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'scala', 'sbt', 'java' },
        callback = function()
          require('metals').initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })
    end
  }


  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
