return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
    keys = {
      { "<leader>vd", "<cmd>Gvdiffsplit master:%<cr>", desc = "Diff current file vs master" },
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles", "DiffviewRefresh" },
    keys = {
      { "<leader>vD", "<cmd>DiffviewOpen master<cr>", desc = "Diff all files vs master" },
      { "<leader>vh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current file)" },
      { "<leader>vH", "<cmd>DiffviewFileHistory<cr>", desc = "File history (repo)" },
      { "<leader>vc", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        vim.keymap.set("n", "gb", function()
          gs.blame_line({ full = true })
        end, { buffer = bufnr, desc = "Git blame line" })
      end,
    },
  },
}
