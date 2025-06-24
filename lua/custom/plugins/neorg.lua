-- NOTE: Note taking engine: https://github.com/nvim-neorg/neorg

return {
  'nvim-neorg/neorg',
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = '*', -- Pin Neorg to the latest stable release
  dependencies = { { 'nvim-lua/plenary.nvim', 'nvim-neorg/neorg-telescope' } },
  config = function()
    local neorg = require 'neorg'

    neorg.setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {
          config = {
            icon_preset = 'diamond',
          },
        },
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/notes',
            },
            default_workspace = 'notes',
          },
        },
        ['core.pivot'] = {},
        ['core.itero'] = {},
        ['core.promo'] = {},
        ['core.integrations.telescope'] = {},
      },
    }

    vim.keymap.set({ 'i', 'n' }, '<M-cr>', '<plug>(neorg.itero.next-iteration)')
    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}
