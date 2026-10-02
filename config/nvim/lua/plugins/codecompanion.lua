return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      interactions = {
        chat = {
          adapter = {
            name = "ollama",
            model = "qwen3-coder:30b",
          },
        },
        inline = {
          adapter = {
            name = "ollama",
            model = "qwen3-coder:30b",
          },
        },
      },
    },
    keys = {
      {
        "<leader>cc",
        "<cmd>CodeCompanionChat Toggle<cr>",
        mode = { "n", "v" },
        desc = "CodeCompanion Chat",
      },
      {
        "<leader>ci",
        "<cmd>CodeCompanion<cr>",
        mode = { "n", "v" },
        desc = "CodeCompanion Inline",
      },
    },
  },
}
