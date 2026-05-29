return {
	--{
		--"igorlfs/nvim-dap-view",
		---- let the plugin lazy load itself
		--lazy = false,
		--version = "1.*",
		-----@module 'dap-view'
		-----@type dapview.Config
		--opts = {
			--winbar = {
				--controls = {
					--enabled = true,
				--},
			--},
		--},
	--},
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            require("dapui").setup()
        end,
    },
	{
		"mfussenegger/nvim-dap-python",
		config = function()
			require("dap-python").setup("uv")
			local dap = require("dap")
			for _, config in ipairs(dap.configurations.python) do
				config.justMyCode = false
			end
		end,
	},
}
