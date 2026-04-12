"*****************************************************************************
"" Ctags Plugins
"*****************************************************************************
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
