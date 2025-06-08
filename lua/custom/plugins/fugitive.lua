-- A Git wrapper so awesome, it should be illegal

return {
  'tpope/vim-fugitive',
  name = 'fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = '[G]it [S]tatus' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
