return {
  "catppuccin/nvim",
  as = "catppuccin",
  config = function()
    vim.cmd("colorscheme catppuccin-mocha")
    vim.cmd("highlight Cursor guifg=#aa0000 guibg=#aa0000")
  end
}
