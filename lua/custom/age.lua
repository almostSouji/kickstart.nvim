-- INFO: age (https://github.com/FiloSottile/age) integration

local M = {}

local KEY_FILE = 'C:/users/souji/.ssh/id_ed'

M.key = KEY_FILE

M.is_age = function()
  local contents = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local content = table.concat(contents, '\n')
  return vim.startswith(content, '-----BEGIN AGE ENCRYPTED FILE-----')
end

vim.api.nvim_create_user_command('AgeEncrypt', function()
  vim.cmd("'[,']!age -R " .. M.key .. '.pub --armor')
  vim.cmd 'write'
  vim.cmd 'silent undo'

  local project_path = vim.fn.expand '%:p'
  local undo_path = vim.fn.undofile(project_path)

  os.remove(undo_path)
end, { nargs = 0 })

vim.api.nvim_create_user_command('AgeDecrypt', function()
  if M.is_age() then
    vim.cmd("'[,']!age -d -i " .. M.key)
  end
end, { nargs = 0 })

vim.api.nvim_create_user_command('AgeSetkey', function(opts)
  M.key = opts.fargs[1]
  print('Set age key: ' .. M.key)
end, { nargs = 1 })

vim.api.nvim_create_user_command('AgeReadKey', function()
  print('Current age key: ' .. M.key)
end, { nargs = 0 })

-- flow taken off of https://github.com/benoror/gpg.nvim/blob/main/plugin/gpg.lua
local ageGroup = vim.api.nvim_create_augroup('customAge', { clear = true })

vim.api.nvim_create_autocmd({ 'BufReadPre', 'FileReadPre' }, {
  pattern = '*.age*',
  group = ageGroup,
  callback = function()
    -- do not write shada or swapfile
    vim.opt_local.shada = nil
    vim.opt_local.swapfile = false
    -- save buffer local "ch" opt value
    vim.b.ch_save = vim.o.ch
    vim.o.ch = 2
  end,
})

vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileReadPost' }, {
  pattern = '*.age*',
  group = ageGroup,
  callback = function()
    if M.is_age() then
      vim.cmd("'[,']!age -d -i " .. M.key)
    end
    -- restore "ch" option
    vim.o.ch = vim.b.ch_save
    -- reset "ch" option cache
    vim.b.ch_save = nil
  end,
})

vim.api.nvim_create_autocmd({ 'BufWritePre', 'FileWritePre' }, {
  pattern = '*.age*',
  group = ageGroup,
  callback = function()
    vim.cmd("'[,']!age -R " .. M.key .. '.pub --armor')
  end,
})

vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufWritePost' }, {
  pattern = '*.age*',
  group = ageGroup,
  callback = function()
    if M.is_age() then
      vim.cmd 'silent undo'
    end

    local project_path = vim.fn.expand '%:p'
    local undo_path = vim.fn.undofile(project_path)

    os.remove(undo_path)
  end,
})

return M
