return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		lazy = false,
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_enable = {
					exclude = {
						"pyright",
					},
				},
			})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),

				callback = function(event)
					local opts = { noremap = true, silent = true }
					local keymap = vim.api.nvim_buf_set_keymap
					keymap(event.buf, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
					keymap(event.buf, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
					keymap(event.buf, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
					keymap(event.buf, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
					keymap(event.buf, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
					keymap(event.buf, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
					keymap(event.buf, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
					keymap(event.buf, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
					keymap(event.buf, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
					keymap(event.buf, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
					keymap(event.buf, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
					keymap(event.buf, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
					keymap(event.buf, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					keymap(event.buf, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
					keymap(event.buf, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
				end,
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls_status_ok, null_ls = pcall(require, "null-ls")
			if not null_ls_status_ok then
				return
			end

			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics

			null_ls.setup({
				debug = true,
				sources = {
					formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
					--formatting.black.with({ extra_args = { "--fast" } }),
					formatting.stylua,
					null_ls.builtins.formatting.prettier.with({
						extra_filetypes = { "toml" },
					}),
					null_ls.builtins.formatting.terraform_fmt,
					--require("none-ls.diagnostics.flake8"), --pydoclint,
					--null_ls.builtins.diagnostics.pydoclint.with({
					--args = { "--show-filenames-in-every-violation-message=true", "$FILENAME" },
					--to_stderr = true, -- collect lines from stderr
					--format = "line", -- send each line to on_output
					--}),
				},
			})
		end,
	},
}
