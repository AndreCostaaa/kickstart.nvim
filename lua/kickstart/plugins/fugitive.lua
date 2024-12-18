return {
  'tpope/vim-fugitive',
  config = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

    vim.keymap.set('n', '<leader>p', function()
      vim.cmd.Git 'push'
    end, opts)

    vim.keymap.set('n', '<leader>P', function()
      vim.cmd.Git { 'pull', '--merge' }
    end, opts)
    vim.keymap.set('n', '<leader>t', ':Git push -u origin ', opts)
  end,
}
