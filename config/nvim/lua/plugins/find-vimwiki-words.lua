return {
  "fab/find-vimwiki-words.nvim",
  url = "https://codeberg.org/fab/find-vimwiki-words.nvim.git",
  lazy = false,
  dependencies = { { "vimwiki/vimwiki" }, { "nvim-telescope/telescope.nvim" } },
  keys = {
    {
      "<leader>tw",
      function()
        require("find-vimwiki-words").find_vimwiki_words()
      end,
      desc = "Telescope Find VimWiki words",
    },
  },
}
