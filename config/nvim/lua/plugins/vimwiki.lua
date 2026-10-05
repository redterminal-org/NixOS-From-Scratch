return {
  "vimwiki/vimwiki",
  lazy = false,
  -- event = { BufEnter = "*.wiki" },
  init = function()
    -- Setting Configuration
    vim.cmd([[
      let g:vimwiki_root = $HOME . "/Work/VimWiki"
      let g:vimwiki_list = [{"path": $HOME . "/Work/VimWiki", "syntax": "markdown", "ext": ".wiki"}]
      let g:vimwiki_key_mappings = {}
      let g:vimwiki_key_mappings.table_mappings = 0
      let g:vimwiki_nested_syntaxes = { 'bash': 'sh', 'python': 'python', 'go': 'go', 'yaml': 'yaml', 'json': 'json' }
      let g:vimwiki_conceal_pre = 1
      let g:vimwiki_conceallevel = 3
      let g:vimwiki_global_ext = 0
      let g:vimwiki_folding = "expr"
      let g:markdown_folding_level = 3
      let g:UltiSnipExpandTrigger = "<C-s>"
      setlocal textwidth=80
      highlight VimWikiHeader1 guifg=#22FFFF
      highlight VimWikiHeader2 guifg=#22C0C0
      highlight VimWikiHeader3 guifg=#228080
      highlight VimWikiHeader4 guifg=#228022
      highlight VimWikiHeader5 guifg=#44A044
      highlight VimWikiHeader6 guifg=#66FF66
    ]])
  end,
}
