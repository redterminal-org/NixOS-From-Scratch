return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        bash = { "shfmt" },
        sh = { "shfmt" },
        go = { "gofumpt", "goimports" },
        python = { "ruff_format" },
        nix = { "nixfmt" },
      },
    },
  },
}
