return {
  { "tpope/vim-surround", event = "VeryLazy" },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n" },
      { "gc", mode = { "n", "v" } },
    },
    opts = {
      mappings = { basic = true, extra = false },
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>w",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash jump",
      },
    },
    opts = {},
  },

  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },
}
