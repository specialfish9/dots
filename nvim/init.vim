" sane dafaults
set noerrorbells
set noshowmatch
set noshowmode
set hidden
set nowrap
set smartcase
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.config/nvim/undodir
set undofile
set nohlsearch
set incsearch
set scrolloff=10
" set cursorline
set shortmess+=c
set shell=/bin/bash
set mouse-=a
set lazyredraw
set ttyfast

" set tabs(as spaces) sizes
set tabstop=2 softtabstop=2
set shiftwidth=2
set smartindent
set expandtab

" display line numbers
set number
set relativenumber

" lower update times for a better experience
set updatetime=50

" line length gutter. 
set colorcolumn=80

" mappings with leader key
let mapleader = " "

" jump back to where you left off
" from: https://askubuntu.com/a/202077
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

call plug#begin()
Plug 'ryanoasis/vim-devicons'

" essentials (status line, commenter, zen mode)
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'

" mattua mod
Plug 'wadackel/vim-dogrun'
Plug 'arzg/vim-colors-xcode'
Plug 'dracula/vim'
Plug 'davidhalter/jedi-vim'
" lsp & navigation
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" -----------------------------------------------------------------------------
" appearance
" -----------------------------------------------------------------------------
hi clear
if exists("syntax_on") 
 syntax reset 
endif
set termguicolors
colorscheme dracula

" -----------------------------------------------------------------------------
" lightline
" -----------------------------------------------------------------------------

" configure lightline
" \ 'colorscheme': 'monokaipro',
let g:lightline = {
  \ 'colorscheme': 'darcula',
  \ 'active': {
  \   'left': [ [ 'mode' ], 
  \             [ 'readonly', 'filename', 'modified' ] ],
  \   'right': [
  \     [ 'lineinfo' ],
  \     [ 'percent' ],
  \     [ 'filetype' ],
  \   ] 
  \ },
  \ 'component_function': {
  \   'filetype': 'FileType',
  \ }
\ }

function! FileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : '') : ''
endfunction

" -----------------------------------------------------------------------------
" coc & fzf
" -----------------------------------------------------------------------------

" neovim native LSPs
lua << EOF
  local lspconfig = require('lspconfig')
  
  local on_attach = function(client, buffer)
    require'completion'.on_attach(client, buffer)
    require'lsp_signature'.on_attach()
  end

  local servers = {'dartls', 'pyright', 'clangd', 'jdtls'}
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
    }
  end
EOF

au BufWritePre *.h,*.hpp,*.c,*.cpp,*.go,*py,*.dart,*.java, lua vim.lsp.buf.formatting_sync(nil, 1000)

" autocomplete settings
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy = ['exact', 'substring', 'fuzzy']
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" diagnostic settings
call sign_define("LspDiagnosticsErrorSign", {"text" : ""})
call sign_define("LspDiagnosticsWarningSign", {"text" : ""})
call sign_define("LspDiagnosticsInformationSign", {"text" : "כֿ",})
call sign_define("LspDiagnosticsHintSign", {"text" : "כֿ",})

" -----------------------------------------------------------------------------
" binds
" -----------------------------------------------------------------------------

" movement and reiszing across splits
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

noremap <leader>H :vertical resize +5<CR>
noremap <leader>J :resize -5<CR>
noremap <leader>K :resize +5<CR>
noremap <leader>L :vertical resize -5<CR>

" other bindings
nnoremap <leader>p <CMD>Telescope find_files<CR>
nnoremap <leader>f <CMD>Telescope live_grep<space><CR>

" <c-space> to trigger completion.
imap <silent><c-space> <Plug>(completion_trigger)
" coc bindings
nnoremap <silent>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent>gf <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent>K  <cmd>lua vim.lsp.buf.hover()<CR>

" map <ESC> in terminal
tnoremap <ESC> <C-\><C-n>

" goyo hooks
function! s:goyo_enter()
  set wrap linebreak

  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  set nowrap nolinebreak

  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

:command WQ wq
:command Wq wq
:command W w
:command Q q
