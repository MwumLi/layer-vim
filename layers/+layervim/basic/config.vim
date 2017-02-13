" vim: set ts=2 sts=2 sw=2 :

scriptencoding utf-8

" 避免重复加载
if exists('g:loaded_layervim_better_default') && g:loaded_layervim_better_default
  finish
endif
let g:loaded_layervim_better_default = 1

" 避免续行效应: http://man.chinaunix.net/newsoft/vi/doc/usr_41.html
let s:save_cpo = &cpo
set cpo&vim

set nocompatible
set backspace=indent,eol,start " Backspace for dummies


" appearance {
  syntax on                      " Syntax highlighting
  filetype plugin indent on      " Automatically detect file types

  set t_Co=256            " 开启 256 色
  set number              " 行号
  set relativenumber      " Relative numbers on
  set report=0            " Always report changed lines
  set linespace=0         " No extra spaces between rows
  set ruler               " 右下角显示光标的行列信息
  set cursorline          " 行光标线
  set cursorcolumn        " 列光标线
  set laststatus=2        " 总是显示状态栏
  set showmatch           " 当光标移动到一个括号时高亮显示对应的另一个括号
  set showcmd             " 回显输入的命令
  set showmode            " 显示当前的模式
  set showmatch           " Show matching brackets/parentthesis
  set matchtime=5         " Show matching time
  set display=lastline    " Show as much as possible of the last line
  set lazyredraw          " 解决某些类型的文件由于syntax导致vim反应过慢的问题
  set ttyfast             " Faster redrawing
  set fileformats=unix,dos,mac    " 设置文件类型
  set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶
  " http://stackoverflow.com/questions/6427650/vim-in-tmux-background-color-changes-when-paging/15095377#15095377
  set t_ut=
" }

" http://blog.csdn.net/softmanfly/article/details/50490391
" encoding {
  set encoding=utf-8      " Set default encoding
  set termencoding=utf-8  " 输出到客户终端（Term）采用的编码类型
  set fileencoding=utf-8  " vim 写入文件时采用的编码类型
  set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936 " 自动判断编码时 依次尝试一下编码
" }

" mouse {
  if exists('g:layervim_better_default_enable_mouse') && g:layervim_better_default_enable_mouse
    set mouse=a           " Automatically enable mouse usage
    set mousehide         " Hide the mouse cursor while typing
    set ttymouse=xterm2
    set scrolljump=1      " 当光标达到上端或下端时 翻滚的行数
    set so=6              " 上下滚行时空余6行
  endif
" }

" Change cursor shape for iTerm2 on macOS {
  " bar in Insert mode
  " inside iTerm2
  if $TERM_PROGRAM =~# 'iTerm'
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    if exists('&t_SR')
      let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    endif
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif

  " inside tmux
  if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    if exists('&t_SR')
      let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
    endif
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  endif
" }

" search {
  set ignorecase  " 搜索时大小写不敏感
  set smartcase   " 如果搜索字符串里包含大写字母，则禁用 ignorecase
  set hlsearch    " 高亮显示搜索结果
  set incsearch   " 开启实时搜索
" }

" indent {
  filetype indent on  " 自适应不同语言的智能缩进
  set autoindent      " Indent at the same level of the previous line
  set smartindent     " 智能对齐
  if exists('g:layervim_better_default_tab_as_spaces') && g:layervim_better_default_tab_as_spaces
    let s:tabstop = g:layervim_better_default_tab_as_spaces
  else
    let s:tabstop = 8
  endif
  " http://www.w3cschool.cn/vim/c9lbkozt.html
  let &shiftwidth=s:tabstop    " Nunber of spaces per indent
  let &softtabstop=s:tabstop
  let &tabstop=s:tabstop       " Number of spaces per <Tab>
  set expandtab               " 编辑时将制表符扩展为空格,已存在的文件不会进行这样的替换,如需要,则使用 :retab
  set smarttab        " 按一下 Backspace 就删除 4 个空格
" }

" 断行设置 {
  set textwidth=80            " 一行显示 80 字符
  if exists('g:layervim_better_default_no_wrap') && g:layervim_better_default_no_wrap
    set nowrap
    set sidescroll=6          " 当光标达到水平极端时 移动的列数
  else
    set wrap                  " 设置自动折行, 超过 textwidth, 则折行
  endif
  set linebreak               " 不在单词中间断行
  set fo+=mB                  " 断行对汉字的支持
  set whichwrap+=<,>,h,l      " 允许backspace和光标键跨越行边界
" }

" fold {
  set foldmethod=indent                     " 折叠方式
  set nofoldenable                          " 不自动折叠
  set foldcolumn=1                          " 在行号前空出一列的宽度
" }

" window {
  set splitright     " Puts new vsplit windows to the right of the current
  set splitbelow     " Puts new split windows to the bottom of the current
  " 分割的窗口间显示空白
  set fillchars=vert:\ ,stl:\ ,stlnc:\ 
" }

" use system copyboard {
  if has('unnamedplus')
    set clipboard=unnamedplus,unnamed
  else
    set clipboard+=unnamed
  endif
" }

" http://vimcdoc.sourceforge.net/doc/undo.html
" undo - 无限回退 {
  if exists('g:layervim_better_default_persistent_undo') && g:layervim_better_default_persistent_undo
    if has('persistent_undo')
      set undodir=~/.vim/undodir  " 指定撤销文件路径(默认撤销文件通常保存在文件本身相同的目录里)
      set undofile                " Persistent undo
      set undolevels=1000         " Maximum number of changes that can be undone
      set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    endif
  endif
" }

" cmdline {
  set wildmenu    " 开启 Vim 自身命令行模式智能补全
  set wildmode=list:longest,full " http://vimcdoc.sourceforge.net/doc/options.html#'wildmode'
" }

" other {
  set shortmess=atOI             " 启动时不显示捐助乌干达儿童的提示
  set autoread                   " Automatically read a file changed outside of vim
  set autowrite                  " Automatically write a file when leaving a modified buffer
  set complete-=i                " Exclude files completion
  set history=10000              " Maximum history record
  set viminfo+=!                 " Viminfo include !
" }

if has('gui_running')
  set guioptions-=r        " Hide the right scrollbar
  set guioptions-=L        " Hide the left scrollbar
  set guioptions-=T
  set guioptions-=e
  set shortmess+=c
  " No annoying sound on errors
  set noerrorbells
  set novisualbell
  set visualbell t_vb=
endif

execute 'source' fnamemodify(expand('<sfile>'), ':h') . '/autocmd.vim'
execute 'source' fnamemodify(expand('<sfile>'), ':h') . '/keybindings.vim'

let &cpo = s:save_cpo
unlet s:save_cpo
