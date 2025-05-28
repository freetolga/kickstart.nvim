return {
    base46 = {
    theme = "solarized_dark", -- default theme
    hl_add = {},
    hl_override = {},
    integrations = {},
    changed_themes = {},
    transparency = false,
  },


      ui = {
    cmp = {
      icons_left = false, -- only for non-atom styles!
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    },

    telescope = { enabled = false }, -- borderless / bordered

    statusline = {
      enabled = true,
      theme = "default", -- default/vscode/vscode_colored/minimal
      separator_style = "block",
      order = nil,
      modules = nil,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = false,
      bufwidth = 21,
    },
  },

  nvdash = {enabled = false
  },

  term = {enabled = false
  },

  lsp = { signature = true },

  cheatsheet = {enabled = false
  },

  mason = {enabled = false},

  colorify = {enabled = false
  },
}
