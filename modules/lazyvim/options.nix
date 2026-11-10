{ pkgs, lib, ... }:

{
  home.activation.installUltiSnips = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p "$HOME/.config/nvim/UltiSnips"
    $DRY_RUN_CMD cp -rn \
      ${../../config/nvim/UltiSnips}/. \
      "$HOME/.config/nvim/UltiSnips/"
  '';

  programs.lazyvim.enable = true;

  programs.lazyvim.config.options = ''
    vim.g.trouble_lualine = false

    -- Add command ":BufferBytes" to see how many bytes a buffer consumes
    vim.api.nvim_create_user_command("BufferBytes", function()
      local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      local bytes = #table.concat(lines, "\n")
      print(bytes .. " Bytes")
    end, {})
  '';

  programs.lazyvim.extras = {
    # Go
    lang.go = {
      enable = true;
      installDependencies = false;
      installRuntimeDependencies = false;
    };

    # Nix
    lang.nix.enable = true;

    # Python
    lang.python = {
      enable = true;
      installDependencies = false;
      installRuntimeDependencies = false;
    };

    # Rust
    lang.rust.enable = true;
  };

  programs.lazyvim.treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
    bash
    rust
    go
    gomod
    gowork
    gosum
    ron

    # Markdown tables and VimWiki in Markdown mode
    markdown
    markdown_inline
  ];
}
