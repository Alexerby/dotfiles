-- Function to call the notetaker script
function notetaker()
    vim.cmd("silent !/path/to/your/notetaker-script.sh")
    vim.cmd("e ~/Dropbox/notes/src/note-" .. vim.fn.strftime("%Y-%m-%d") .. ".md")
end

-- Bind the notetaker function to a key (e.g., <leader>n)
vim.api.nvim_set_keymap('n', '<leader>n', ':lua notetaker()<CR>', { noremap = true, silent = true })
