{ ... }:

{
  programs.lazyvim.plugins = {
      goyo = ''
        return {
          {
            "junegunn/goyo.vim",
            init = function()
              vim.g.goyo_width = "80%"
            end,
          },
        }
      '';

      ultisnips = ''
        return {
          "SirVer/ultisnips",
          "honza/vim-snippets",
        }
      '';

      vimwiki = ''
        return {
          {
            "vimwiki/vimwiki",
            lazy = false,

            init = function()
              vim.cmd([[
                let g:vimwiki_root = $HOME . "/Work/VimWiki"
                let g:vimwiki_list = [
                  \ {
                  \   "path": $HOME . "/Work/VimWiki",
                  \   "syntax": "markdown",
                  \   "ext": ".wiki"
                  \ }
                  \ ]

                let g:vimwiki_key_mappings = {}
                let g:vimwiki_key_mappings.table_mappings = 0

                let g:vimwiki_nested_syntaxes = {
                  \ 'bash': 'sh',
                  \ 'python': 'python',
                  \ 'go': 'go',
                  \ 'yaml': 'yaml',
                  \ 'json': 'json'
                  \ }

                let g:vimwiki_conceal_pre = 1
                let g:vimwiki_conceallevel = 3
                let g:vimwiki_global_ext = 0
                let g:vimwiki_folding = "expr"
                let g:markdown_folding_level = 3
                let g:UltiSnipExpandTrigger = "\<C-s>"

                highlight VimWikiHeader1 guifg=#22FFFF
                highlight VimWikiHeader2 guifg=#22C0C0
                highlight VimWikiHeader3 guifg=#228080
                highlight VimWikiHeader4 guifg=#228022
                highlight VimWikiHeader5 guifg=#44A044
                highlight VimWikiHeader6 guifg=#66FF66
              ]])

              _G.VimwikiLinkHandler = function(link)
                local path
                local kind

                if link:match("^yazi:") then
                  kind = "yazi"
                  path = link:gsub("^yazi:", "", 1)
                elseif link:match("^zathura:") then
                  kind = "zathura"
                  path = link:gsub("^zathura:", "", 1)
                elseif link:match("^file://") then
                  path = vim.uri_to_fname(link)
                elseif link:match("^file:") then
                  path = link:gsub("^file:", "", 1)
                elseif link:match("^~/") or link:match("^/") then
                  path = link
                else
                  return 0
                end

                path = path:gsub("%%20", " ")
                path = vim.fn.expand(path)
                path = vim.fn.fnamemodify(path, ":p")

                if vim.fn.isdirectory(path) == 1 then
                  if kind == "zathura" then
                    return 0
                  end

                  local ok, yazi = pcall(require, "yazi")
                  if not ok then
                    vim.notify(
                      "yazi.nvim is not loaded",
                      vim.log.levels.ERROR
                    )
                    return 1
                  end

                  yazi.yazi(nil, path)
                  return 1
                end

                if vim.fn.filereadable(path) == 1
                  and path:lower():match("%.pdf$") then
                  if kind == "yazi" then
                    return 0
                  end

                  local job = vim.fn.jobstart({
                    "zathura",
                    path,
                  }, {
                    detach = true,
                  })

                  if job <= 0 then
                    vim.notify(
                      "Failed to launch Zathura",
                      vim.log.levels.ERROR
                    )
                  end

                  return 1
                end

                return 0
              end

              vim.cmd([[
                function! VimwikiLinkHandler(link) abort
                  return v:lua.VimwikiLinkHandler(a:link)
                endfunction
              ]])
            end,
          },
        }
      '';

      renderMarkdown = ''
        return {
          {
            "MeanderingProgrammer/render-markdown.nvim",

            ft = {
              "markdown",
              "vimwiki",
            },

            dependencies = {
              "nvim-treesitter/nvim-treesitter",
            },

            opts = {
              file_types = {
                "markdown",
                "vimwiki",
              },

              pipe_table = {
                enabled = true,
                wrap = true,
                cell = "padded",
                style = "full",
                padding = 1,
                min_width = 8,
              },
            },

            config = function(_, opts)
              -- VimWiki uses the "vimwiki" filetype.
              -- Tree-sitter should use Markdown for this filetype.
              vim.treesitter.language.register(
                "markdown",
                "vimwiki"
              )

              require("render-markdown").setup(opts)
            end,
          },
        }
      '';
  };
}
