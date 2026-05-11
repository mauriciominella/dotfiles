return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { ";", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>o", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>j", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>cb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current buffer fuzzy" },
      { "<leader>ct", "<cmd>Telescope current_buffer_tags<cr>", desc = "Current buffer tags" },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
    },
    opts = {
      defaults = {
        prompt_prefix = "λ ",
        path_display = { "smart" },
      },
      pickers = {
        find_files = { hidden = true },
      },
    },
  },
}
