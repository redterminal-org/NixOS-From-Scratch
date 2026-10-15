-- Add command ":BufferBytes" to see how many bytes a buffer consumes
vim.api.nvim_create_user_command("BufferBytes", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local bytes = #table.concat(lines, "\n")
  print(bytes .. " Bytes")
end, {})
