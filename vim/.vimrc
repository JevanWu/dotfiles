"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
let mapleader = " "
set nocompatible               " be iMproved
set clipboard=unnamed
set hidden
filetype off                   " required!
" set cursorline

" set ruler
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
" set mouse=a

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" trime white space in the end of lines
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
autocmd BufWritePre     * :call TrimWhiteSpace()
colorscheme onedark

" let g:NERDTreeWinPos = "right"
set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar

nnoremap <silent> <leader>A v$h
nnoremap <silent> <leader>I v^

syntax enable
" Use new regular expression engine
set re=0
filetype plugin indent on     " required!
set omnifunc=syntaxcomplete#Complete

" Highlight current line
" au WinLeave * set nocursorline nocursorcolumn
" au WinEnter * set cursorline cursorcolumn
" set cursorline cursorcolumn

"*****************************************************************************
"" My Plugins
"*****************************************************************************
" let Vundle manage Vundle
" required!
call plug#begin('~/.vim/plugged')

Plug 'bagrat/vim-buffet'
" Plug 'ap/vim-buftabline'

" Note: Make sure the function is defined before `vim-buffet` is loaded.
function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#00FF00 guifg=#000000
endfunction

" original repos on github
Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
map <Leader> <Plug>(easymotion-prefix)

Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

"vim-coffee-script
Plug 'kchmck/vim-coffee-script'

" vim-scripts repos
" Plug 'L9'
"Plug 'FuzzyFinder'

Plug 'scrooloose/nerdtree'
map <C-t> :NERDTreeToggle<CR>
map <leader>t :NERDTreeFind<CR>

"SnipMate
Plug 'msanders/snipmate.vim'

"""autocomplete
"""Plug 'valloric/youcompleteme'

"tcomment
Plug 'tomtom/tcomment_vim'
"codeschool
" Plug '29decibel/codeschool-vim-theme'
"the-silver-search
" Plug 'rking/ag.vim'

Plug 'tpope/vim-surround'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" config for airline
let g:airline#extensions#tabline#enabled = 1

" auto complete close pairs
Plug 'jiangmiao/auto-pairs'
"let g:AutoPairsUseInsertedCount = 1

Plug 'tpope/vim-endwise'

" Plug 'vim-ruby/vim-ruby'

Plug 'janko-m/vim-test'

Plug 'Shougo/unite.vim'
" Plug 'devjoe/vim-codequery'
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
" t Ctrl+n
nmap <silent> t<C-f> :TestFile<CR>
" t Ctrl+f
nmap <silent> t<C-s> :TestSuite<CR>
" t Ctrl+s
" nmap <silent> t<C-l> :TestLast<CR>
" t Ctrl+l
" nmap <silent> t<C-g> :TestVisit<CR>
" t Ctrl+g

Plug 'dyng/ctrlsf.vim'
vmap <C-f> <Plug>CtrlSFVwordExec
nmap <C-f> <Plug>CtrlSFPrompt

" copy into the system clipboard
vmap <C-y> "*y

Plug 'christoomey/vim-tmux-navigator'

" If installed using HomebrewrecUploaded
set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'
"nmap <Leader><C-f> :Files<CR>
nmap <C-p> :Files<CR>
nmap <C-b> :Buffers<CR>
nnoremap <leader>] :Tags <c-r><c-w><cr>

Plug 'benmills/vimux'
" Prompt for a command to run
nmap <Leader>vp :VimuxPromptCommand<CR>
nmap <Leader>vc :VimuxCloseRunner<CR>
" Plug 'pgr0ss/vimux-ruby-test'
Plug 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js'

Plug 'airblade/vim-gitgutter'

"
"Syntax checking hacks for vim
Plug 'scrooloose/syntastic'

"Multiple Cursors
Plug 'terryma/vim-multiple-cursors'

"ctags
" Plug 'szw/vim-tags'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
set statusline+=%{gutentags#statusline()}
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_add_default_project_roots=0
let g:gutentags_project_root = ['.git', '.root']
" 用作debug的
"let g:gutentags_trace = 1

" 所生成的数据文件的名称 "
" let g:gutentags_ctags_tagfile = '.git/tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let g:gutentags_cache_dir = expand('~/.cache/tags/')

" change focus to quickfix window after search (optional).
" let g:gutentags_plus_switch = 1

" enable gtags module
" let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_ctags_auto_set_tags = 1
"

let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0


" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" Plug 'majutsushi/tagbar'
" " config for tagbar
" let g:tagbar_width=35
" let g:tagbar_autofocus=1
" nmap <Leader>8 :TagbarToggle<CR>

" the frontend plugin
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'jelera/vim-javascript-syntax'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'moll/vim-node'
" Plug 'marijnh/tern_for_vim'

" Flutter Plugin
" Plug 'dart-lang/dart-vim-plugin'
" Plug 'thosakwe/vim-flutter'

"" Markdown
Plug 'plasticboy/vim-markdown'
" disable folding
let g:vim_markdown_folding_disabled = 1
"" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0
nmap <C-s> <Plug>MarkdownPreview

call plug#end()

"*****************************************************************************
"" My key bindings
"*****************************************************************************
" buffer switch shortcut
map <Leader>n :bn<CR>
map <Leader>d :bd<CR>
map <Leader>p :bp<CR>
map <Leader>c :enew<CR>


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
