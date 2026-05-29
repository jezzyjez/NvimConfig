return {
	"scalameta/nvim-metals",
	ft = { "scala", "sbt", "java" },
	config = function()
		local metals_config = require("metals").bare_config()

		metals_config.settings = {
			showImplicitArguments = true,
			showImplicitConversionsAndClasses = true,
			showInferredType = true,
			superMethodLensesEnabled = true,
			disabledMode = false,
		}
		metals_config.init_options.statusBarProvider = "on"
		metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
		metals_config.on_attach = function(client, bufnr)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
			vim.keymap.set("n", "K", vim.lsp.buf.hover)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
			vim.keymap.set("n", "gr", vim.lsp.buf.references)
			vim.keymap.set("n", "gds", vim.lsp.buf.document_symbol)
			vim.keymap.set("n", "gws", vim.lsp.buf.workspace_symbol)
			vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run)
			vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
			vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
		end

		local nvim_metals_grnup = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "scala", "sbt", "java" },
			callback = function()
                print("Metals autocmd triggered for filetype: " .. vim.bo.filetype)
                require("metals").initialize_or_attach(metals_config)
				--require("metals").start_server()
			end,
			group = nvim_metals_group,
		})
	end,
}
