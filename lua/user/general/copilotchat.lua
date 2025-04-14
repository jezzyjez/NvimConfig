require("CopilotChat").setup {
  -- See Configuration section for options
contexts = {
  git_diff = {
    input = function(callback)
      vim.ui.select({'HEAD'}, {
        prompt = 'branch ',
      }, callback)
    end,
    resolve = function(input)
      local branch = input or 'HEAD'
      local diff_cmd = { 'git', 'diff', 'master...' .. branch }

      local result = {}
      vim.fn.jobstart(diff_cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data)
          if data then
            for _, line in ipairs(data) do
              table.insert(result, line)
            end
          end
        end,
        on_exit = function()
          local content = table.concat(result, '\n')
          local output = {
            {
              content = content,
              filename = 'git_diff_' .. branch,
              filetype = 'diff',
            }
          }
          -- Ensure the output is returned properly
          vim.schedule(function()
            callback(output)
          end)
        end
      })
    end
  }
  }
}
