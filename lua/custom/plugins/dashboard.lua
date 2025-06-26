-- INFO: start screen dashboard https://github.com/goolord/alpha-nvim
return {
  'goolord/alpha-nvim',
  dependencies = { 'echasnovski/mini.icons' },
  config = function()
    local alpha = require 'alpha'
    local theta = require 'alpha.themes.theta'
    local dash = require 'alpha.themes.dashboard'
    local daytime = {
      [[                                                       ]],
      [[                                                       ]],
      [[                                                       ]],
      [[                                                       ]],
      [[                  |\      _,,,---,,_                   ]],
      [[                 / ,`.-'`'   -.  ;-,'-,,_              ]],
      [[                 |,4-  ) )-,_. ´\ (  `'-,##>           ]],
      [[                ' --''(_/--'  `-'\_)                   ]],
      [[]],
      '                  ' .. os.date '%d/%m/%Y %X',
    }

    local nighttime = {
      [[. ⭑  ⋆     .  ⭑        .    ✦     .     ⭑ +     ⋆  +  .]],
      [[         ✦       ⭑ ' +    ⋆            .      .  ⭑     ]],
      [[   ⭑.        ⭑ '  .           '   +              .⋆   ']],
      [[   .     .             ✦        '      ⭑ '        .    ]],
      [[       ⭑   Z      |\      _,,,---,,_          ⭑        ]],
      [[  +         Z    / ,`.-'`'   -.  ;-,'-,,_             ⋆]],
      [[             Zz  |,4-  ) )-,_. ´\ (  `'-,##>           ]],
      [[                ' --''(_/--'  `-'\_)                   ]],
      [[]],
      '                  ' .. os.date '%d/%m/%Y %X',
    }

    local current_hour = tonumber(os.date '%H')
    local banner = (current_hour < 8 or current_hour > 19) and nighttime or daytime

    theta.header.val = banner
    -- uses syntax highlight
    -- theta.header.opts.hl = ''

    -- dashboard buttons
    theta.buttons.val = {
      dash.button('i', '󰠮  Notes Index', '<cmd>Neorg index<CR>'),
      dash.button('n', '󱓧  Find Notes', '<Plug>(neorg.telescope.find_norg_files)'),
      dash.button('e', '󰒲  Edit Dashboard', '<cmd>e ~/AppData/Local/nvim/lua/custom/plugins/dashboard.lua<CR>'),
      dash.button('u', '  Update plugins', '<cmd>Lazy sync<CR>'),
      dash.button('q', '󰅚  Quit', '<cmd>qa<CR>'),
    }

    alpha.setup(theta.config)
    vim.api.nvim_create_user_command('Dash', function(_)
      alpha.start(false, theta.config)
    end, { nargs = 0 })
  end,
}
