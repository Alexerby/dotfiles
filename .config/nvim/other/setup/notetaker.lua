-- Function to call the notetaker script
function notetaker()
    vim.cmd("silent !/path/to/your/notetaker-script.sh")
    vim.cmd("e ~/Dropbox/notes/src/note-" .. vim.fn.strftime("%Y-%m-%d") .. ".md")
end

