--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
--require("general.ruff")
require("general.keymaps")
require("general.nerd-tree")
require("general.colorscheme")
require("general.telescope")
require("general.bufferline")
require("general.options")
require("lsp.settings.pyright")

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = "all",
  -- Install parsers synchronously (only applied to `ensure_installed`)
  ignore_install = { "ipkg", "norg" }, -- List of parsers to ignore installing
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
vim.lsp.config('ruff', {
  init_options = {
    settings = {
      -- Ruff language server settings go here
    }
  }
})

vim.lsp.enable('ruff')
