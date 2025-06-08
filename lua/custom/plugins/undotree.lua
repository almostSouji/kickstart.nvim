-- Undo history visualizer

return {
  'mbbill/undotree',
  name = 'undotree',
  priority = 1000,
  config = function()
    vim.g.undotree_DiffCommand =
    'FC' -- WARNING: required for windows, as "diff" is not a default command; remove line if on unix
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndo tree' })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
