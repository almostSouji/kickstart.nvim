-- Soothing pastel theme for the high-spirited!

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin-mocha'
  end,
}

-- vim: ts=2 sts=2 sw=2 et
