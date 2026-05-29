return {
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup()
    end,
    -- stylua: ignore
    keys = {
      { "<leader>gy", function() require("gitlinker").get_buf_range_url("n") end, desc = "Yank Git URL (line)",  mode = "n" },
      { "<leader>gy", function() require("gitlinker").get_buf_range_url("v") end, desc = "Yank Git URL (range)", mode = "v" },
    },
  },
}
