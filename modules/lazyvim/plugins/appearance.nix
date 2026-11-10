{ ... }:

{
  programs.lazyvim.plugins = {
      lualine = ''
        return {
          {
            "nvim-lualine/lualine.nvim",
            opts = function(_, opts)
              for _, section in pairs(opts.sections) do
                for _, component in ipairs(section) do
                  if type(component) == "table"
                    and component[1] == "diagnostics" then
                    component.sources = { "nvim_diagnostic" }
                    component.sections = { "error", "warn", "info", "hint" }
                    component.update_in_insert = false
                    component.always_visible = false
                    return
                  end
                end
              end
            end,
          },
        }
      '';

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
  };
}
