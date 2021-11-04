vim.lsp.set_log_level("debug")

require'visimp'{
  defaults = {
    foldmethod = 'marker'
  },
  languages = {
   'c', 'python', 'latex', 'dart', 'ocaml'
  },
  python = {
    lsp = 'pyright' -- Avoid installing pyright, use the system's default
  },
 latex = {
   tectonic = true
 },
  theme = {'bluz71/vim-nightfly-guicolors', 'nightfly', 'dark'}
}

vim.cmd('command! Wq wq')
vim.cmd('command! WQ wq')
vim.cmd('command! W w')
vim.cmd('command! Q q')
