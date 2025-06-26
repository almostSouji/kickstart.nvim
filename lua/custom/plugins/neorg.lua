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

    vim.api.nvim_create_autocmd('BufEnter', {
      group = vim.api.nvim_create_augroup('neorg-buf-enter', { clear = true }),
      callback = function(_)
        if vim.bo.filetype == 'norg' then
          vim.keymap.set('i', '<M-cr>', '<plug>(neorg.itero.next-iteration)')
          vim.o.foldlevel = 99
          vim.o.conceallevel = 2
        end
      end,
    })
  end,
}
