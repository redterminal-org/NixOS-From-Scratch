{ pkgs, lib, ... }:

{
  # ---------------------------------------------------------------
  # Custom Neovim configuration
  # ---------------------------------------------------------------

  home.file.".config/nvim/lua/config/keymaps.lua".source = ../config/nvim/lua/config/keymaps.lua;

  home.file.".config/nvim/lua/config/options.lua".source = ../config/nvim/lua/config/options.lua;

  # ---------------------------------------------------------------
  # UltiSnips
  # ---------------------------------------------------------------

  # Copy snippets only if they do not already exist.
  home.activation.installUltiSnips = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p "$HOME/.config/nvim/UltiSnips"
    $DRY_RUN_CMD cp -rn \
      ${../config/nvim/UltiSnips}/. \
      "$HOME/.config/nvim/UltiSnips/"
  '';

  # ---------------------------------------------------------------
  # LazyVim
  # ---------------------------------------------------------------

  programs.lazyvim = {
    enable = true;

    # -------------------------------------------------------------
    # LazyVim Extras
    # -------------------------------------------------------------

    extras = {
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

    # -------------------------------------------------------------
    # Tree-sitter parsers
    # -------------------------------------------------------------

    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
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

    # -------------------------------------------------------------
    # Declarative plugin configuration
    #
    # Each former file from config/nvim/lua/plugins/*.lua
    # is defined here as a LazyVim plugin specification.
    # -------------------------------------------------------------

    plugins = {

      # -----------------------------------------------------------
      # Gopher syntax
      # Formerly: gopher-syntax.lua
      # -----------------------------------------------------------

      gopherSyntax = ''
        return {
          "pinpox/vim-gopher-syntax",
        }
      '';

      # -----------------------------------------------------------
      # Linter
      # Formerly: linter.lua
      # -----------------------------------------------------------

      linter = ''
        return {
          {
            "mfussenegger/nvim-lint",
            opts = {
              linters_by_ft = {
                sh = { "shellcheck" },
                bash = { "shellcheck" },
              },
            },
          },
        }
      '';

      # -----------------------------------------------------------
      # LSP
      # Formerly: lsp.lua
      # -----------------------------------------------------------

      lsp = ''
        return {
          {
            "neovim/nvim-lspconfig",
            opts = {
              servers = {
                lua_ls = {},
                bashls = {},
              },
            },
          },
        }
      '';

      # -----------------------------------------------------------
      # VimWiki word search via Telescope
      # Formerly: find-vimwiki-words.lua
      # -----------------------------------------------------------

      findVimwikiWords = ''
        return {
          {
            "fab/find-vimwiki-words.nvim",
            url = "https://codeberg.org/fab/find-vimwiki-words.nvim.git",
            lazy = false,
            dependencies = {
              "vimwiki/vimwiki",
              "nvim-telescope/telescope.nvim",
            },
            keys = {
              {
                "<leader>tw",
                function()
                  require("find-vimwiki-words").find_vimwiki_words()
                end,
                desc = "Telescope Find VimWiki words",
              },
            },
          },
        }
      '';

      # -----------------------------------------------------------
      # Goyo
      # Formerly: goyo.lua
      # -----------------------------------------------------------

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

      # -----------------------------------------------------------
      # UltiSnips and vim-snippets
      # Formerly: ultisnips.lua
      # -----------------------------------------------------------

      ultisnips = ''
        return {
          "SirVer/ultisnips",
          "honza/vim-snippets",
        }
      '';

      # -----------------------------------------------------------
      # VimWiki
      # Formerly: vimwiki.lua
      # -----------------------------------------------------------

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

      # -----------------------------------------------------------
      # Tokyo Night
      # Formerly: colorscheme.lua
      # -----------------------------------------------------------

      colorscheme = ''
        return {
          {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            opts = {
              terminal_colors = true,
            },
          },
          {
            "LazyVim/LazyVim",
            opts = {
              colorscheme = "tokyonight-storm",
            },
          },
        }
      '';

      # -----------------------------------------------------------
      # Gen.nvim / Ollama
      # Formerly: gen.lua
      # -----------------------------------------------------------

      gen = ''
        return {
          {
            "David-Kunz/gen.nvim",
            opts = {
              model = "translategemma:12b",
              host = "localhost",
              port = "11434",
              body = {
                stream = true,
                keep_alive = 0,
              },
              init = function()
                pcall(
                  io.popen,
                  "ollama serve > /dev/null 2>&1 &"
                )
                vim.fn.system({
                  "ollama",
                  "stop",
                  "gpt-oss:20b",
                })
              end,
            },

            config = function(_, opts)
              local gen = require("gen")
              gen.setup(opts)

              gen.prompts["Translate to German"] = {
                prompt = "You are a professional translator. Detect the source language and translate the following text into German. Produce only the German translation, without any additional explanations or commentary.\n\n$text",
                replace = true,
              }

              gen.prompts["Translate to English"] = {
                prompt = "You are a professional translator. Detect the source language and translate the following text into English. Produce only the English translation, without any additional explanations or commentary.\n\n$text",
                replace = true,
              }
            end,
          },
        }
      '';

      # -----------------------------------------------------------
      # CodeCompanion / Ollama
      # Formerly: codecompanion.lua
      # -----------------------------------------------------------

      codecompanion = ''
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
                    return require(
                      "codecompanion.adapters"
                    ).extend("ollama", {
                      handlers = {
                        form_parameters = function(
                          self,
                          params,
                          messages
                        )
                          vim.fn.system({
                            "ollama",
                            "stop",
                            "translategemma:12b",
                          })

                          return require(
                            "codecompanion.adapters.http.openai"
                          ).handlers.form_parameters(
                            self,
                            params,
                            messages
                          )
                        end,
                      },

                      schema = {
                        num_ctx = {
                          default = 32786,
                        },
                        keep_alive = {
                          default = "-1m",
                        },
                      },
                    })
                  end,
                },
              },

              tools = {
                read_file = {
                  opts = {
                    require_approval_before = false,
                  },
                },
                grep_search = {
                  opts = {
                    require_approval_before = false,
                  },
                },
                file_search = {
                  opts = {
                    require_approval_before = false,
                  },
                },
                get_diagnostics = {
                  opts = {
                    require_approval_before = false,
                  },
                },
                get_changed_files = {
                  opts = {
                    require_approval_before = false,
                  },
                },
                insert_edit_into_file = {
                  opts = {
                    require_approval_before = false,
                  },
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
                  adapter = {
                    name = "ollama",
                    model = "gpt-oss:20b",
                  },

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

                inline = {
                  adapter = {
                    name = "ollama",
                    model = "gpt-oss:20b",
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

            config = function(_, opts)
              require("codecompanion").setup(opts)

              vim.api.nvim_create_autocmd("VimLeavePre", {
                callback = function()
                  vim.fn.system({
                    "ollama",
                    "stop",
                    "gpt-oss:20b",
                  })
                end,
              })
            end,
          },
        }
      '';

      # -----------------------------------------------------------
      # Markdown rendering and table wrapping
      # New: does not replace any existing plugin file
      # -----------------------------------------------------------

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

      # -----------------------------------------------------------
      # Yazi
      # Previously defined directly in Nix
      # -----------------------------------------------------------

      yazi = ''
        return {
          "mikavilpas/yazi.nvim",
          version = "*",
          event = "VeryLazy",

          dependencies = {
            {
              "nvim-lua/plenary.nvim",
              lazy = true,
            },
          },

          keys = {
            {
              "<leader>r",
              mode = { "n", "v" },
              "<cmd>Yazi<cr>",
              desc = "Open Yazi",
            },
          },

          opts = {
            open_for_directories = false,
            open_multiple_tabs = false,

            config_home =
              vim.fn.fnamemodify(
                vim.fn.stdpath("config"),
                ":h"
              ) .. "/yazi-lazyvim",

            floating_window_scaling_factor = 0.85,
            yazi_floating_window_winblend = 0,
            yazi_floating_window_border = "rounded",

            open_file_function = function(chosen_file, config, state)
              if chosen_file:lower():match("%.pdf$") then
                vim.fn.jobstart({ "zathura", chosen_file }, {
                  detach = true,
                })
                return
              end

              -- Preserve the plugin's default behavior for other files.
              vim.cmd.edit(vim.fn.fnameescape(chosen_file))
            end,
          },
        }
      '';

      # -----------------------------------------------------------
      # Snacks
      # Previously defined directly in Nix
      # -----------------------------------------------------------

      snacks = ''
        return {
          {
            "folke/snacks.nvim",
            opts = {
              lazygit = {
                configure = false,
              },
            },
          },
        }
      '';

      # -----------------------------------------------------------
      # Custom filetypes
      # Previously defined directly in Nix
      # -----------------------------------------------------------

      filetypes = ''
        return {
          {
            "LazyVim/LazyVim",

            opts = function()
              vim.filetype.add({
                filename = {
                  ["gophermap"] = "gopher",
                },
                extension = {
                  gph = "gopher",
                  gmi = "gemtext",
                },
              })

              vim.api.nvim_create_autocmd("FileType", {
                pattern = "gopher",

                callback = function()
                  vim.opt_local.expandtab = false
                  vim.opt_local.tabstop = 4
                  vim.opt_local.shiftwidth = 4
                  vim.opt_local.softtabstop = 4
                  vim.opt_local.textwidth = 67
                  vim.opt_local.cc = "67"
                end,
              })

              vim.api.nvim_create_autocmd("FileType", {
                pattern = "gemtext",

                callback = function()
                  vim.opt_local.expandtab = false
                  vim.opt_local.tabstop = 4
                  vim.opt_local.shiftwidth = 4
                  vim.opt_local.softtabstop = 4
                  vim.opt_local.textwidth = 0
                  vim.opt_local.cc = "0"
                  vim.opt_local.wrap = true
                end,
              })
            end,
          },
        }
      '';
    };
  };
}
