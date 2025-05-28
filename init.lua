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

local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('nvim-lua/plenary.nvim')
Plug('nvchad/base46')
Plug('nvchad/ui')
Plug('nvim-treesitter/nvim-treesitter')
Plug('neovim/nvim-lspconfig')
Plug('saghen/blink.cmp', {['tag'] = 'v1.*'}) Plug('stevearc/conform.nvim')

vim.call('plug#end')

 for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
   dofile(vim.g.base46_cache .. v)
 end

require("nvchad")
require("base46")

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
  },
})
blink_cmp_opts = {
    keymap = { preset = 'default' },

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

vim.lsp.enable('zls', {
    capabilities = require('blink.cmp').get_lsp_capabilities()
})

vim.lsp.enable('clangd', {
    capabilities = require('blink.cmp').get_lsp_capabilities()
})

