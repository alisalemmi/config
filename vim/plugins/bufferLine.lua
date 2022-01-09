local function closeBuffer(bufnum)
  local currentBuffer = vim.fn.bufnr()

  if (currentBuffer == bufnum)
  then
    require('bufdelete').bufdelete(bufnum)
  else
    vim.cmd('buffer' .. bufnum)
    require('bufdelete').bufdelete(bufnum)
    vim.cmd('buffer' .. currentBuffer)
  end
end

require('bufferline').setup{
  options = {
    close_command = closeBuffer,
    right_mouse_command = closeBuffer,
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        highlight = 'Directory',
        text_align = 'center'
      }
    }
  }
}
