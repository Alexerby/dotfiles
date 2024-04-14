-- Define a function to execute the command
function GENERATE_MERMAID_DIAGRAM()
    local input_file = vim.fn.expand("%")
    local output_file = vim.fn.expand("%:r") .. ".png"
    local command = string.format('npx @mermaid-js/mermaid-cli -i %s -o %s', input_file, output_file)
    vim.fn.system(command)
end

