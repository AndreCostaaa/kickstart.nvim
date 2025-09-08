local auto_fmt_enabled = true

local enable_auto_fmt = function()
  auto_fmt_enabled = true
end

local disable_auto_fmt = function()
  auto_fmt_enabled = false
end

vim.api.nvim_create_user_command('EnFmt', enable_auto_fmt, {})
vim.api.nvim_create_user_command('DisFmt', disable_auto_fmt, {})

return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = false, cpp = false }

      if not auto_fmt_enabled then
        return
      end

      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'black' },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      html = { 'prettier' },
      tsx = { 'prettier' },
      typescript = { 'prettier' },
      json = { 'prettier' },
      cs = { 'csharpier' },
      c = { 'clang-format' },
      sv = { 'verible' },
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      javascript = { { 'prettierd', 'prettier' } },
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  },
}
