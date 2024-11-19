function my_wonderful_theme()
  local fortune = require('alpha.fortune')

    local header = {
        type = "text",
        val = {
            "visimp is cool!"
        },
        opts = {
            position = "center",
            hl = "Type",
        },
    }

  local footer = {
    type = 'text',
    val = fortune(),
    opts = {
      position = 'center',
      hl = 'Number',
    },
  }

  return {
    layout = {
      { type = 'padding', val = 12 },
      header,
      { type = 'padding', val = 2 },

      -- Accordingly to alpha-nvim doc, this empty button component is required
      -- for the correct placement of the cursor while the greeter is displayed
      { type = 'button', val = '' },

      footer,
    },
    opts = {
      margin = 5,
    },
  }
end

require'visimp'{
  defaults = {
    foldmethod = 'marker'
  },
  languages = {
   'c', 'python', 'latex', 'java', 'go', 'javascript', 'vue', 'ocaml', 'dart', 'typst', 'gleam'
  },
  python = {
    lsp = 'pyright' -- Avoid installing pyright, use the system's default
  },
 latex = {
   tectonic = true
 },
  theme = {
    -- package = 'bluz71/vim-nightfly-guicolors',
    -- colorscheme = 'nightfly',
    -- background = 'dark',
    -- lualine = 'nightfly',
  package = 'bluz71/vim-moonfly-colors',
  colorscheme = 'moonfly',
  background = 'dark'
  },


  typst = {
  lspconfig = {
    experimentalFormatterMode = 'on',
    exportPdf = 'onSave',
  },
},

   -- greeter = {
   --   layout = my_wonderful_theme(),
   -- },
  autopairs = {},
  blankline={
     scope = {
    show_start = false,
    show_end = false,
  },
  },
  cmp = {},
  fugitive = {},
  gitsigns = {},
  snippet = {},
  icons = {},
  lspformat = {
    --exclude = {'ocamllsp'}
  },

  statusline = {
    tabline = {
      lualine_a = { 'buffers' }
    }
  },

  nvimtree = {
    sort_by = "case_sensitive",
    view = {
      width = 30
      -- mappings = {
      --   list = {
      --     { key = "u", action = "dir_up" },
      --   },
      --},
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    }
  },

  binds = {
    [{ mode = 'n', bind = '<C-P>' }] = ':bprev<cr>',
    [{ mode = 'n', bind = '<C-N>' }] = ':bnext<cr>',
    [{ mode = 'n', bind = '<C-T>' }] = ':NvimTreeToggle<cr>',
    [{ mode = 'n', bind = '<C-Q>' }] = ':quit<cr>',
  },
}

vim.cmd('command! Wq wq')
vim.cmd('command! WQ wq')
vim.cmd('command! W w')
vim.cmd('command! Q q')
