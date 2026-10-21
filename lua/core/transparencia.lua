return function()
  vim.cmd([[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NormalNC guibg=NONE ctermbg=NONE
    highlight VertSplit guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight StatusLine guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    highlight Pmenu guibg=NONE ctermbg=NONE
    highlight PmenuSel guibg=NONE ctermbg=NONE
    highlight TelescopeBorder guibg=NONE ctermbg=NONE
    highlight TelescopeNormal guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
    highlight Whitespace guibg=NONE ctermbg=NONE
    highlight SpecialKey guibg=NONE ctermbg=NONE
    highlight NonText guibg=NONE ctermbg=NONE
  ]])
end
