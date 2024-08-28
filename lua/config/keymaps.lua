vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>pv", function() vim.cmd("Ex") end)

vim.keymap.set("n", "<leader>m", ":NvimTreeFindFile<CR>")
vim.keymap.set("n", "<leader>n", ":NvimTreeToggle<CR>")
