-- Set up gruvbox
function ColorMyPencils(color)
    color = color or "gruvbox"
    vim.cmd("colorscheme " .. color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()

-- vim.cmd([[colorscheme gruvbox]])

vim.g.gruvbox_contrast_dark = 'soft'
vim.g.gruvbox_bold = 1
vim.g.gruvbox_italic = 1

vim.g.gruvbox_transparent_bg = 1 -- Enable transparent background
vim.g.gruvbox_italicize_comments = 1 -- Italicize comments
vim.g.gruvbox_underline_error = 1 -- Underline error messages

