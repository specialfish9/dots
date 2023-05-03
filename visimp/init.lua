require'visimp'{
  defaults = {
    foldmethod = 'marker'
  },
  languages = {
   'c', 'python', 'latex', 'dart', 'java', 'go', 'javascript', 'vue', 'ocaml'
  },
  python = {
    lsp = 'pyright' -- Avoid installing pyright, use the system's default
  },
 latex = {
   tectonic = true
 },
  theme = {
    package = 'bluz71/vim-nightfly-guicolors',
    colorscheme = 'nightfly',
    background = 'dark',
    lualine = 'nightfly',
  },

  autopairs = {},
  cmp = {},
  comment = {},
  fugitive = {},
  gitsigns = {},
  snippet = {},
  outline = {},
  icons = {},

  nvimtree = {
    sort_by = "case_sensitive",
    view = {
      width = 30,
      mappings = {
        list = {
          { key = "u", action = "dir_up" },
        },
      },
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    }
  }
}

vim.cmd('command! T NvimTreeToggle')
vim.cmd('command! Wq wq')
vim.cmd('command! WQ wq')
vim.cmd('command! W w')
vim.cmd('command! Q q')
