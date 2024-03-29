"*****************************************************************************
"" Ruby on Rails Plugins
"*****************************************************************************
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'

Plug 'janko-m/vim-test'

Plug 'Shougo/unite.vim'
" Plug 'devjoe/vim-codequery'
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
" nmap <silent> t<C-n> :TestNearest<CR>
" t Ctrl+n
nmap <silent> t<C-f> :TestFile<CR>
" t Ctrl+f
nmap <silent> t<C-s> :TestSuite<CR>
" t Ctrl+s
" nmap <silent> t<C-l> :TestLast<CR>
" t Ctrl+l
" nmap <silent> t<C-g> :TestVisit<CR>
" t Ctrl+g
