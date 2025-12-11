require "visimp" {
    defaults = {
        foldmethod = "marker"
    },
    languages = {
        "python",
        "latex",
        "java",
        "go",
        "javascript",
        "typst",
        "rust"
    },
    python = {
        lsp = "pyright" -- Avoid installing pyright, use the system's default
    },
    rust = {
        lsp = "rust_analyzer"
    },
    latex = {
        tectonic = true
    },
    typst = {
        lspconfig = {
            experimentalFormatterMode = "on",
            exportPdf = "onSave"
        }
    },
    theme = {
        -- package = 'bluz71/vim-nightfly-guicolors',
        -- colorscheme = 'nightfly',
        -- background = 'dark',
        -- lualine = 'nightfly',
        package = "bluz71/vim-moonfly-colors",
        colorscheme = "moonfly",
        background = "dark"
    },
    autopairs = {},
    blankline = {
        scope = {
            show_start = false,
            show_end = false
        }
    },
    cmp = {
        mapping = {
            ["<Down>"] = function(cmp)
                return cmp.mapping.select_next_item()
            end,
            ["<Up>"] = function(cmp)
                return cmp.mapping.select_prev_item()
            end,
            ["<CR>"] = function(cmp)
                return cmp.mapping.confirm({select = true})
            end,
            ["<C-e>"] = function(cmp)
                return cmp.config.disable
            end,
            ["<Tab>"] = function(cmp)
                return cmp.config.disable
            end,
            ["<S-Tab>"] = function(cmp)
                return cmp.config.disable
            end
        }
    },
    gitsigns = {},
    snippet = {},
    icons = {},
    lspformat = {},
    lspsignature = {
        ignore_error = function(err, ctx, config)
            if ctx and ctx.client_id then
                local client = vim.lsp.get_client_by_id(ctx.client_id)
                if client and vim.tbl_contains({ 'rust_analyzer' }, client.name) then
                    return true
                end
            end
        end
    },
    ltex = {
        language = "en-GB",
        dictionary = {
            ["en-US"] = {
                "adaptivity",
                "precomputed",
                "subproblem"
            }
        }
    },
    statusline = {
        tabline = {
            lualine_a = {"buffers"}
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
            group_empty = true
        },
        filters = {
            dotfiles = true
        }
    },
    binds = {
        [{mode = "n", bind = "<C-P>"}] = ":bprev<cr>",
        [{mode = "n", bind = "<C-N>"}] = ":bnext<cr>",
        [{mode = "n", bind = "<C-T>"}] = ":NvimTreeToggle<cr>",
        [{mode = "n", bind = "<C-Q>"}] = ":quit<cr>"
    }
}

vim.cmd("command! Wq wq")
vim.cmd("command! WQ wq")
vim.cmd("command! W w")
vim.cmd("command! Q q")

