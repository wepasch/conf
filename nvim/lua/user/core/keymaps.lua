vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>nh", "nohl<CR>", { desc = "Clear seach highlights" }) --not working 
keymap.set("n", "<leader>+", "<C-x>", { desc = "inc by 1" })
keymap.set("n", "<leader>+", "<C-a>", { desc = "dec by 1" })
