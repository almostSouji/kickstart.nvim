-- INFO: start screen dashboard https://github.com/goolord/alpha-nvim
return {
  'goolord/alpha-nvim',
  dependencies = { 'echasnovski/mini.icons' },
  config = function()
    local alpha = require 'alpha'
    local theta = require 'alpha.themes.theta'
    local dash = require 'alpha.themes.dashboard'

    theta.header.val = {
      [[ Z      |\      _,,,---,,_         ]],
      [[  Z    / ,`.-'`'   -.  ;-,'-,,_    ]],
      [[   Zz  |,4-  ) )-,_. ´\ (  `'-,##> ]],
      [[      ' --''(_/--'  `-'\_)         ]],
      [[]],
      '        ' .. os.date '%d/%m/%Y %X',
    }

    -- uses syntax highlight
    -- theta.header.opts.hl = ''

    -- dashboard buttons
    theta.buttons.val = {
      dash.button('n', '󱓧  Open Notes', '<cmd>Neorg index<CR>'),
      dash.button('e', '󰒲  Edit Dashboard', '<cmd>e ~/AppData/Local/nvim/lua/custom/plugins/dashboard.lua<CR>'),
      dash.button('u', '  Update plugins', '<cmd>Lazy sync<h'),
      dash.button('q', '󰅚  Quit', '<cmd>qa<CR>'),
    }

    alpha.setup(theta.config)
  end,
}
