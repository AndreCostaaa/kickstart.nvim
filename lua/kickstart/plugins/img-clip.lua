return {
  'HakonHarnes/img-clip.nvim',
  event = 'VeryLazy',
  opts = {
    default = {
      dir_path = 'media',
      extension = 'png',
      file_name = '%Y-%m-%d_%H-%M-%S',
      insert_mode_after_paste = false,
      copy_images = true,
    },

    filetypes = {
      markdown = {
        template = '![$FILE_NAME]($FILE_PATH)\n$CURSOR',
      },
    },
  },
  keys = {
    { '<leader>P', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
  },
}
