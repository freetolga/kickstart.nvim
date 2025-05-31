vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.number = true
vim.o.cp = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.breakindent = true
vim.o.backup = flse
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.hidden = false
vim.o.autoread = true
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"
vim.g.have_nerd_font = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.undofile = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true

-- clipboard sync --
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Keep signcolumn on by default --
vim.o.signcolumn = 'yes'
local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('nvim-lua/plenary.nvim')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-treesitter/nvim-treesitter')
Plug('neovim/nvim-lspconfig')
Plug('dense-analysis/ale')
Plug('saghen/blink.cmp', {['tag'] = 'v1.*'}) Plug('stevearc/conform.nvim')

vim.call('plug#end')

 for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
   dofile(vim.g.base46_cache .. v)
 end

--require("nvchad")

require('nvim-treesitter.configs').setup({
  auto_install = false,
  ignore_install = { "all" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})


require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    rust = { "rustfmt", lsp_format = "fallback" },
    zig = {"zig fmt"},
    cpp = {"clang-format"},
    c = {"clang-format"},
    arduino = {"clang-format"},
  },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
formatters = {
				clang_format = {
					args = function()
						-- Fetch indentation settings dynamically
						local shiftwidth = vim.api.nvim_get_option("shiftwidth")
						local expandtab = vim.api.nvim_get_option("expandtab")

						-- Build args based on Vim settings
						local args = { "--style={BasedOnStyle: llvm, " }

						-- Add tab width based on shiftwidth
						table.insert(args, "IndentWidth: " .. shiftwidth)

						-- Use tabs or keep spaces
						if expandtab then
							table.insert(args, ", TabWidth: " .. shiftwidth)
							table.insert(args, ", UseTabs: Always")
						end

						table.insert(args, " }")
						return args
					end,
				},
			},

})

blink_cmp_opts = {
    keymap = { 
        preset = 'default',
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },

    },

    appearance = {
      nerd_font_variant = 'mono'
    },

    completion = { documentation = { auto_show = false } },

    sources = {
      default = { 'lsp', 'path', 'buffer' },
    },

    fuzzy = { implementation = "rust" }
}
require('blink.cmp').setup(blink_cmp_opts)

local lsp_opts = {
    capabilities = require('blink.cmp').get_lsp_capabilities()
}

vim.lsp.enable('zls', lsp_opts)
vim.lsp.enable('clangd', lsp_opts)
vim.lsp.enable('gopls', lsp_opts)
vim.lsp.enable('arduino_language_server')

vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
}


require('lualine').setup {
    options = {
        theme = "auto"
    }
}
-- Configuration goes here.
        local g = vim.g

        g.ale_ruby_rubocop_auto_correct_all = 1

        g.ale_linters = {
            ruby = {'rubocop', 'ruby'},
            lua = {'lua_language_server'},
            cpp = {'cppcheck', 'clang-tidy'},
            c = {'cppcheck', 'clang-tidy'},
        }
g.ale_use_neovim_diagnostics_api = 1
