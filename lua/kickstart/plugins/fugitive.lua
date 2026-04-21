return {
  'tpope/vim-fugitive',
  config = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
  end,
}
