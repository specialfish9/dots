vim.lsp.set_log_level("debug")

require'visimp'{
  defaults = {
    foldmethod = 'marker'
  },
  languages = {
   'c', 'python', 'latex', 'dart'
  },
  python = {
    lsp = 'pyright' -- Avoid installing pyright, use the system's default
  },
 latex = {
   tectonic = true
 },
  theme = {'dracula/vim', 'dracula', 'dark'}
}

vim.cmd('command! Wq wq')
vim.cmd('command! WQ wq')
vim.cmd('command! W w')
vim.cmd('command! Q q')
