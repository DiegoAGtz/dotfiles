-- Keybindings
local function map(m, k, v)
    vim.keymap.set(m, k, v, {silent = true})
end

-- Load recent sessions
map("n", "<leader>sl", "<CMD>SessionLoad<CR>")

-- Keybindings for telescope
map("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>")
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
map("n", "<leader>fb", "<CMD>Telescope wfile_browser<CR>")
map("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")
map("n", "<leader>fc", "<CMD>Telescope colorscheme<CR>")

-- Nvim-Tree
map("n", "<leader>op", "<CMD>NvimTreeToggle<CR>")

-- Better move around
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", '<leader><leader>x', "<CMD>source %<CR>")
map("n", '<leader>x', ":.lua<CR>")
map("v", '<leader>x', ":lua<cr>")
