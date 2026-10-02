return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        http = {
          ollama = function()
            return require("codecompanion.adapters").extend("ollama", {
              handlers = {
                form_parameters = function(self, params, messages)
                  vim.fn.system({ "ollama", "stop", "translategemma:12b" })
                  return require("codecompanion.adapters.http.openai").handlers.form_parameters(self, params, messages)
                end,
              },
              schema = {
                keep_alive = { default = "-1m" },
              },
            })
          end,
        },
      },
      interactions = {
        chat = { adapter = { name = "ollama", model = "qwen3-coder:30b" } },
        inline = { adapter = { name = "ollama", model = "qwen3-coder:30b" } },
      },
    },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Chat" },
      { "<leader>ci", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "CodeCompanion Inline" },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          vim.fn.system({ "ollama", "stop", "qwen3-coder:30b" })
        end,
      })
    end,
  },
}
