"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
let mapleader = " "
set nocompatible               " be iMproved
set clipboard=unnamed
set hidden
filetype off                   " required!

set number
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set autoread
set encoding=utf-8
set scrolloff=999
set mouse=a

set nobackup
set nowb
set noswapfile

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" trime white space in the end of lines
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
autocmd BufWritePre     * :call TrimWhiteSpace()
colorscheme onedark

set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar

syntax enable
" Use new regular expression engine
set re=0
filetype plugin indent on     " required!
set omnifunc=syntaxcomplete#Complete

"*****************************************************************************
"" My key bindings
"*****************************************************************************
" buffer switch shortcut
map <Leader>n :bn<CR>
map <Leader>d :bd<CR>
map <Leader>p :bp<CR>
map <Leader>c :enew<CR>
" copy into the system clipboard
vmap <C-y> "*y
" select content from cursor to end of line
nnoremap <silent> <leader>A v$h
" select content from cursor to start of line
nnoremap <silent> <leader>I v^
" past with register 0, which store the last yanked content
noremap <leader>p "0p

"*****************************************************************************
"" My Plugins
"*****************************************************************************
call plug#begin('~/.vim/plugged')

if filereadable(expand("~/vim/plugins.vim"))
  source ~/vim/plugins.vim
endif
if filereadable(expand("~/vim/ctags_plugins.vim"))
  source ~/vim/ctags_plugins.vim
endif
if filereadable(expand("~/vim/ruby_plugins.vim"))
  source ~/vim/ruby_plugins.vim
endif
if filereadable(expand("~/vim/js_plugins.vim"))
  source ~/vim/js_plugins.vim
endif

call plug#end()

"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" :echo @%                |" directory/name of file
" :echo expand('%:t')     |" name of file ('tail')
" :echo expand('%:p')     |" full path
" :echo expand('%:p:h')   |" directory containing file ('head')
function Meow()
  echom expand('%:p')
endfunction
