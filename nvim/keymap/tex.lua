function check_extension()
    local file_extension = vim.fn.expand('%:e')
    if file_extension ~= 'tex' then
        print("This function is only intended for TeX files.")
        return false
    end
    return true
end

function create_tex_table()
    if not check_extension() then
        return
    end

    local table_content = {
        "\\begin{table}[h]",
        "    \\centering",
        "    \\begin{tabular}{|c|c|}",
        " ",
        "    \\end{tabular}",
        "\\end{table}"
    }
    vim.api.nvim_put(table_content, 'l', true, true)

    vim.fn.feedkeys('3k', 'n')
    vim.fn.feedkeys('i', 'n')
    vim.fn.feedkeys('\t', 'n')
end


function create_section(level)
  if not check_extension() then return end

  local section_type = (level == 1 and "\\section{}") or (level == 2 and "\\subsection{}") or "\\subsubsection{}"
  local section_content = section_type

  vim.api.nvim_put({ section_content }, 'l', true, true)
  vim.fn.feedkeys('kf}', 'n')
  vim.fn.feedkeys('i', 'n')
end


function align_env()
    if not check_extension() then
        return
    end

    local align_env = {
        "\\begin{align*}",
        "",
        "\\end{align*}",
    }
    vim.api.nvim_put(align_env, 'l', true, true)
    vim.fn.feedkeys('2k', 'n')
    vim.fn.feedkeys('i', 'n')
    vim.fn.feedkeys('\t', 'n')
end



-- Create \section{}, \subsection{} and \subsubsection{}
vim.api.nvim_set_keymap('n', '<leader>q', [[:lua create_section(1)<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>qq', [[:lua create_section(2)<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>qqq', [[:lua create_section(3)<CR>]], { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>tt', [[:lua create_tex_table()<CR>]], { noremap = true, silent = true })

-- Align env
vim.api.nvim_set_keymap('n', '<leader>a', [[:lua align_env()<CR>]], { noremap = true, silent = true })

