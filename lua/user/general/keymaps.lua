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
keymap("n", "<C-h>", ":tabp<CR>", opts)
keymap("n", "<C-l>", ":tabn<CR>", opts)


-- Reload Config

keymap("n", "<leader>rv", ":source $MYVIMRC<CR>", opts)


function _G.ReloadConfig()
  for name,_ in pairs(package.loaded) do
    if name:match('^user') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
end

keymap('n', '<leader>vs', '<Cmd>lua ReloadConfig()<CR>', { silent = true, noremap = true })
vim.cmd('command! ReloadConfig lua ReloadConfig()')


-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<A-l>", ":bnext<CR>", opts)
keymap("n", "<A-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press kj fast to enter
keymap("i", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
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

keymap("n", "<leader>n", ":noh<CR>", opts)
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>a", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>gf", "<cmd>lua require'telescope.builtin'.git_files(require('telescope.themes').get_dropdown({ previewer = true }))<cr>", opts)
-- Without previewer
--keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)

