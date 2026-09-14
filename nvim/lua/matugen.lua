 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#00172e',
    base01 = '#052a49',
    base02 = '#06355c',
    base03 = '#57898a',
    base04 = '#a3ccc6',
    base05 = '#f6dcac',
    base06 = '#f6dcac',
    base07 = '#f6dcac',
    base08 = '#f85525',
    base09 = '#028391',
    base0A = '#8cbfb8',
    base0B = '#faa968',
    base0C = '#81f1fd',
    base0D = '#fbb984',
    base0E = '#96e9dd',
    base0F = '#bef4ec',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#f6dcac',          bg = '#00172e' })
  hi('TelescopeBorder',         { fg = '#57898a',             bg = '#00172e' })
  hi('TelescopePromptNormal',   { fg = '#f6dcac',          bg = '#00172e' })
  hi('TelescopePromptBorder',   { fg = '#57898a',             bg = '#00172e' })
  hi('TelescopePromptPrefix',   { fg = '#faa968',             bg = '#00172e' })
  hi('TelescopePromptCounter',  { fg = '#a3ccc6',  bg = '#00172e' })
  hi('TelescopePromptTitle',    { fg = '#00172e',             bg = '#faa968' })
  hi('TelescopePreviewTitle',   { fg = '#00172e',             bg = '#8cbfb8' })
  hi('TelescopeResultsTitle',   { fg = '#00172e',             bg = '#028391' })
  hi('TelescopeSelection',      { fg = '#f6dcac',          bg = '#06355c' })
  hi('TelescopeSelectionCaret', { fg = '#faa968',             bg = '#06355c' })
  hi('TelescopeMatching',       { fg = '#faa968',             bold = true })
end

-- Register a signal handler for SIGUSR1 (matugen updates).
-- The handler re-requires this module, which re-runs the code below, so the
-- previous handle is stopped first; otherwise handlers double on every signal.
if _G.__matugen_signal then
  _G.__matugen_signal:stop()
  _G.__matugen_signal:close()
end

local signal = vim.uv.new_signal()
_G.__matugen_signal = signal
signal:start(
  'sigusr1',
  vim.schedule_wrap(function()
    package.loaded['matugen'] = nil
    require('matugen').setup()
  end)
)

return M
