return {
  { "christoomey/vim-tmux-navigator", lazy = false },

  {
    "heavenshell/vim-jsdoc",
    build = "make install",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    keys = {
      { "<leader>z", ":JsDoc<CR>", desc = "Generate JSDoc" },
    },
  },

  {
    "xolox/vim-notes",
    dependencies = { "xolox/vim-misc" },
    cmd = { "Note", "RecentNotes", "SearchNotes", "RelatedNotes" },
    init = function()
      vim.g.notes_directories = { "~/Notes/mminella-dev-notes/notes" }
      vim.g.notes_suffix = ".md"
      vim.g.notes_smart_quotes = 0
      vim.g.notes_tab_indents = 0
      vim.g.notes_ruler_text = 0
      vim.g.notes_conceal_url = 0
    end,
  },
}
