"*****************************************************************************
"" Util Plugins
"*****************************************************************************
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
" Prompt for a command to run
nmap <Leader>vp :VimuxPromptCommand<CR>
nmap <Leader>vc :VimuxCloseRunner<CR>

Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>
map <leader>t :NERDTreeFind<CR>

set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'
nmap <C-p> :Files<CR>
nmap <C-b> :Buffers<CR>
nnoremap <leader>] :Tags <c-r><c-w><cr>

Plug 'bagrat/vim-buffet'
Plug 'tpope/vim-fugitive'

Plug 'easymotion/vim-easymotion'
map <Leader> <Plug>(easymotion-prefix)

Plug 'dyng/ctrlsf.vim'
vmap <C-f> <Plug>CtrlSFVwordExec
nmap <C-f> <Plug>CtrlSFPrompt

"tcomment
Plug 'tomtom/tcomment_vim'

Plug 'tpope/vim-surround'

" config for airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1

Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-endwise'

Plug 'alvan/vim-closetag'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.js'

Plug 'airblade/vim-gitgutter'

"Syntax checking hacks for vim
Plug 'scrooloose/syntastic'

"" Markdown
Plug 'plasticboy/vim-markdown'
" disable folding
let g:vim_markdown_folding_disabled = 1
"" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
let g:mkdp_auto_start = 0
nmap <C-s> <Plug>MarkdownPreview
