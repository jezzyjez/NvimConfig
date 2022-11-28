local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "user.general.lsp.mason"
require("user.general.lsp.handlers").setup()
require "user.general.lsp.null-ls"
require "user.general.lsp.illuminate"
