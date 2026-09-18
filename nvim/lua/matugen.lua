 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#242120',
    base01 = '#36312f',
    base02 = '#413b38',
    base03 = '#746965',
    base04 = '#e5dec9',
    base05 = '#e5dec9',
    base06 = '#e5dec9',
    base07 = '#e5dec9',
    base08 = '#c6685d',
    base09 = '#8da388',
    base0A = '#a69680',
    base0B = '#cb9168',
    base0C = '#a5e996',
    base0D = '#e9b896',
    base0E = '#e9c696',
    base0F = '#f4ddbe',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e5dec9',          bg = '#242120' })
  hi('TelescopeBorder',         { fg = '#746965',             bg = '#242120' })
  hi('TelescopePromptNormal',   { fg = '#e5dec9',          bg = '#242120' })
  hi('TelescopePromptBorder',   { fg = '#746965',             bg = '#242120' })
  hi('TelescopePromptPrefix',   { fg = '#cb9168',             bg = '#242120' })
  hi('TelescopePromptCounter',  { fg = '#e5dec9',  bg = '#242120' })
  hi('TelescopePromptTitle',    { fg = '#242120',             bg = '#cb9168' })
  hi('TelescopePreviewTitle',   { fg = '#242120',             bg = '#a69680' })
  hi('TelescopeResultsTitle',   { fg = '#242120',             bg = '#8da388' })
  hi('TelescopeSelection',      { fg = '#e5dec9',          bg = '#413b38' })
  hi('TelescopeSelectionCaret', { fg = '#cb9168',             bg = '#413b38' })
  hi('TelescopeMatching',       { fg = '#cb9168',             bold = true })
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
