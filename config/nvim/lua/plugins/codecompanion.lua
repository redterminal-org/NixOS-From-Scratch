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
                num_ctx = { default = 32786 },
                keep_alive = { default = "-1m" },
              },
            })
          end,
        },
      },
      tools = {
        read_file = {
          opts = { require_approval_before = false },
        },
        grep_search = {
          opts = { require_approval_before = false },
        },
        file_search = {
          opts = { require_approval_before = false },
        },
        get_diagnostics = {
          opts = { require_approval_before = false },
        },
        get_changed_files = {
          opts = { require_approval_before = false },
        },
        insert_edit_into_file = {
          opts = { require_approval_before = false },
        },
        run_command = {
          opts = {
            require_approval_before = false,
            require_cmd_approval = false,
          },
        },
      },
      interactions = {
        chat = {
          adapter = { name = "ollama", model = "gpt-oss:20b" },
          tools = {
            opts = {
              default_tools = {
                "read_file",
                "grep_search",
                "file_search",
                "get_diagnostics",
                "get_changed_files",
                "insert_edit_into_file",
                "run_command",
              },
              approval_mode = "auto",
            },
          },
        },
        inline = { adapter = { name = "ollama", model = "gpt-oss:20b" } },
      },
      --opts = {
      --  log_level = "TRACE",
      --},
    },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Chat" },
      { "<leader>ci", "<cmd>CodeCompanion<cr>",            mode = { "n", "v" }, desc = "CodeCompanion Inline" },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          vim.fn.system({ "ollama", "stop", "gpt-oss:20b" })
        end,
      })
    end,
  },
}
