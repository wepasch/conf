return {
  "catppuccin/nvim",
  as = "catppuccin",
  config = function()
    vim.cmd("colorscheme catppuccin-mocha")
    vim.cmd("highlight Cursor guifg=#282828 guibg=#aa0000")
  end
}
