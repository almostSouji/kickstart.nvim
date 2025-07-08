---@diagnostic disable-next-line unused-local
local day = [[
                                                        
                                                        
                                                        
                   |\      _,,,---,,_                   
            z     / ,`.-'`'   -.  ;-,'-,,_              
              zz  |,4-  ) )-,_. ´\ (  `'-,##>           
                 ' --''(_/--'  `-'\_)                   ]]

---@diagnostic disable-next-line unused-local
local night = [[. ⭑  ⋆     .  ⭑        .    ✦     .     ⭑ +     ⋆  +  .
       ✦       ⭑ ' +    ⋆            .      .  ⭑     
   ⭑.        ⭑ '  .           '   +              .⋆   '
   .     .             ✦        '      ⭑ '        .    
       ⭑   Z      |\      _,,,---,,_          ⭑        
  +         Z    / ,`.-'`'   -.  ;-,'-,,_             ⋆
             Zz  |,4-  ) )-,_. ´\ (  `'-,##>           
                ' --''(_/--'  `-'\_)                   ]]

vim.api.nvim_create_user_command('Dash', ':lua Snacks.dashboard.open()', { nargs = 0 })

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      width = 60,
      formats = {
        header = function()
          local current_hour = tonumber(os.date '%H')
          local is_night = current_hour < 8 or current_hour > 19
          local banner = is_night and night or day
          -- INFO: Snacks.picker.highlights({pattern = "hl_group:^Snacks"})
          local highlight = is_night and 'SnacksPickerIconEnum' or 'file'

          return { banner, align = 'center', hl = highlight }
        end,
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ':~')
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ':h')
            local file = vim.fn.fnamemodify(fname, ':t')
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. '/…' .. file
            end
          end
          local dir, file = fname:match '^(.*)/(.+)$'
          return dir and { { dir .. '/' }, { file } } or { { fname } }
        end,
        key = function(item)
          return { { '[', hl = 'SnacksPickerdir' }, { item.key, hl = 'file' }, { ']', hl = 'SnacksPickerdir' } }
        end,
        desc = function(item)
          --          print(vim.inspect(item))
          return { item.desc, hl = nil }
        end,
      },
      preset = {
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = '󰠮 ', key = 'i', desc = 'Notes Index', action = ':Neorg index' },
          { icon = '󰺄', key = 'n', desc = 'Find Notes', action = ':Telescope neorg find_norg_files' },
          { icon = '󰃶', key = 't', desc = 'Journal Today', action = ':Neorg journal today' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = ' ', key = 'u', desc = 'Lazy Update', action = ':Lazy sync' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        {
          section = 'header',
        },
        function()
          local format = '%d/%m %H:%M'
          local now = os.time()
          local time_modules = vim.tbl_filter(function(entry)
            return entry.enabled or false
          end, {

            { enabled = true, title = 'BER: ' .. os.date(format), align = 'center' },
            { enabled = true, title = 'SFO: ' .. os.date(format, now - 9 * 60 * 60), align = 'center' },
          })

          time_modules[#time_modules].padding = 2

          return time_modules
        end,
        { section = 'recent_files', padding = 2 },
        {
          section = 'keys',
          indent = 1,
          padding = 2,
          gap = 1,
          hl = nil,
        },
        function()
          ---@diagnostic disable-next-line: undefined-global
          local in_git = vim.o.columns > 100 and Snacks.git.get_root() ~= nil
          return {
            pane = 2,
            {
              {
                title = 'Open Issues',
                cmd = 'gh issue list -L 5',
                enabled = in_git,
                section = 'terminal',
                key = 'i',
                action = function()
                  vim.fn.jobstart('gh issue list --web', { detach = true })
                end,
                icon = ' ',
                padding = 1,
              },
              {

                icon = ' ',
                enabled = in_git,
                section = 'terminal',
                title = 'Open PRs',
                cmd = 'gh pr list -L 5',
                key = 'P',
                action = function()
                  vim.fn.jobstart('gh pr list --web', { detach = true })
                end,
                padidng = 1,
              },
              {
                icon = ' ',
                title = 'Git Status',
                enabled = in_git,
                padding = 1,
              },
              {
                cmd = 'git status -s',
                enabled = in_git,
                section = 'terminal',
                padding = 1,
              },
            },
          }
        end,
      },
    },
    indent = { enabled = true },
    scope = { enabled = true },
    bigfile = { enabled = true },
    image = {
      doc = {
        float = true,
        inline = false,
      },
    },
  },
}
