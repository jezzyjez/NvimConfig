local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<S-h>", "<C-w>h", opts)
keymap("n", "<S-j>", "<C-w>j", opts)
keymap("n", "<S-k>", "<C-w>k", opts)
keymap("n", "<S-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":Lex 30<cr>", opts)
-- tab Navigation
--keymap("n", "<C-h>", ":tabp<CR>", opts)
--keymap("n", "<C-l>", ":tabn<CR>", opts)


-- Reload Config

keymap("n", "<leader>rv", ":source $MYVIMRC<CR>", opts)


function _G.ReloadConfig()
  for name, _ in pairs(package.loaded) do
    if name:match('^user') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
end

keymap('n', '<leader>vs', '<Cmd>lua ReloadConfig()<CR>', { silent = true, noremap = true })
vim.cmd('command! ReloadConfig lua ReloadConfig()')


-- Resize with arrows
keymap("n", "<C-s><C-i>", ":resize +2<CR>", term_opts)
keymap("n", "<C-s><C-k>", ":resize -2<CR>", term_opts)
keymap("n", "<C-s><C-h>", ":vertical resize -2<CR>", term_opts)
keymap("n", "<C-s><C-l>", ":vertical resize +2<CR>", term_opts)

-- Navigate buffers
keymap("n", "<C-l>", ":bnext<CR>", opts)
keymap("n", "<C-h>", ":bprevious<CR>", opts)

-- Close buffer

keymap("n", "<C-d>", ":bdelete<CR>", opts)

-- Insert --
-- Press kj fast to enter
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mod1111e
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)


--NVIM tree

keymap("n", "<leader>t", ":NvimTreeToggle<CR>", opts)

-- Set Paste Option --
keymap("n", "<leader>p", ":set paste<CR>", opts)
keymap("n", "<leader>np", ":set nopaste<CR>", opts)

keymap("n", "<C-j>", ":lua vim.lsp.buf.hover()<CR>", opts)


keymap("n", "<leader>n", ":noh<CR>", opts)
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>a", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>gf",
  "<cmd>lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({ previewer = true }))<cr>",
  opts)
-- Without previewer
--keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)


-- null ls --
keymap("n", "<leader>fl", ":lua vim.lsp.buf.format()<CR>", opts)

keymap("n", "<leader>rp", ":%s/\\(flows.*\\)\\n\\d\\+\\s*\\(.*\\)/\\1\\2,/<CR>", opts)

-- octo @ and # completion --
vim.api.nvim_buf_set_keymap(0, "i", "@", "@<C-x><C-o>", { silent = true, noremap = true })
vim.api.nvim_buf_set_keymap(0, "i", "#", "#<C-x><C-o>", { silent = true, noremap = true })

-- debugging

keymap("n", "<leader>df", ":lua require('dap-python').test_class()<CR>", opts)
keymap("n", "<leader>lp", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
keymap("n", "<F5>", ":lua require('dap').continue()<CR>", opts)
keymap("n", "<F6>", ":lua require('dap').step_over()<CR>", opts)
keymap("n", "<F7>", ":lua require('dap').step_into()<CR>", opts)
keymap("n", "<F8>", ":lua require('dap').step_out()<CR>", opts)
keymap("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>B", ":lua require('dap').set_breakpoint()<CR>", opts)
keymap("n", "<leader>dr", ":lua require('dap').repl.open()<CR>", opts)
keymap("n", "<leader>dl", ":lua require('dap').run_last()<CR>", opts)
keymap("n", "<leader>dp", ":lua require('dapui').toggle()<CR>", opts)
keymap("n", "<leader>dt", ":Trouble diagnostics<CR>", opts)
