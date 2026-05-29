return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			-- See Configuration section for options
		},
		-- See Commands section for default commands if you want to lazy load on them
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	},
	{
		"pwntester/octo.nvim",
		commit = "14cc5e70551bebedf2af512b608f62522663eab2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	},
	"tpope/vim-fugitive",
	{
		"NickvanDyke/opencode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = function()
			vim.g.opencode_opts = {
                server = {
                  port = 4096
                },
				provider = {
					enabled = "snacks",
					---@type opencode.provider.Snacks
					snacks = {
						-- Customize `snacks.terminal` to your liking.
					},
				},
			}
		end,
    -- stylua: ignore
    keys = {
      { '<leader>ot', function() require('opencode').toggle() end,                           desc = 'Toggle embedded opencode', },
      { '<leader>oa', function() require('opencode').ask() end,                              desc = 'Ask opencode',                 mode = 'n', },
      { '<leader>oa', function() require('opencode').ask('@this: ') end,                     desc = 'Ask opencode about selection', mode = 'v', },
      { '<leader>op', function() require('opencode').select_prompt() end,                    desc = 'Select prompt',                mode = { 'n', 'v', }, },
      { '<leader>on', function() require('opencode').command('session_new') end,             desc = 'New session', },
      { '<leader>oy', function() require('opencode').command('messages_copy') end,           desc = 'Copy last message', },
      { '<S-C-u>',    function() require('opencode').command('messages_half_page_up') end,   desc = 'Scroll messages up', },
      { '<S-C-d>',    function() require('opencode').command('messages_half_page_down') end, desc = 'Scroll messages down', },
    },
	},
}
