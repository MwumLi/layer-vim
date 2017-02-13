
" Visual shifting (does not exit Visual mode) {
  vnoremap < <gv
  vnoremap > >gv
" }

" Treat long lines as break lines (useful when moving around in them) {
  nmap j gj
  nmap k gk
  vmap j gj
  vmap k gk
" }

" :W sudo saves the file
" (useful for handling the permission-denied error) {
  command! W w !sudo tee % > /dev/null
" }

" file save
nnoremap <Leader>fs :update<CR>

" Quit normal mode {
  nnoremap <Leader>q  :q<CR>
  nnoremap <Leader>Q  :qa!<CR>
" }

" Move half page faster {
  " <C-d> : 向下移动半页
  " <C-u> : 向上移动半页
" }

" Insert mode shortcut {
  inoremap <C-h> <Left>
  inoremap <C-j> <Down>
  inoremap <C-k> <Up>
  inoremap <C-l> <Right>
" }

" like bash {
  inoremap <C-a> <Home>
  inoremap <C-e> <End>
  inoremap <C-d> <Delete>
" }

" Command mode shortcut {
  cnoremap <C-h> <left>
  cnoremap <C-j> <Down>
  cnoremap <C-k> <Up>
  cnoremap <C-l> <Right>
  cnoremap <C-a> <Home>
  cnoremap <C-e> <End>
  cnoremap <C-d> <Delete>
" }


" escaping - Cttrl+c
inoremap <ESc> <C-c>
cnoremap <Esc> <C-c>

" Quit visual mode
vnoremap v <Esc>

" move {
  " jump to the start of line
  nnoremap 1 0
  " jump to the end of line
  nnoremap 0 $
  " jump to the start of line text
  nnoremap H ^
  " jump loop in Pairing characters , such '( ... )', '{  }'
  nnoremap 5 %
  " <C-w>H -- 跳转至左方的窗口
  " <C-w>l -- 跳转至右方的窗口
  " <C-w>k -- 跳转至上方的窗口
  " <C-w>j -- 跳转至下方的窗口
" }

nnoremap ; : " Quick command mode
" Open shell in vim
" :shell

" Search result highlight countermand
nnoremap <Leader>sc :nohlsearch<CR>

" Toggle pastemode
nnoremap <Leader>tp :setlocal paste!<CR>

" window-split {
    " :sp 或 :new -- 上下分割窗口
    " :vsp 或 :vnew -- 左右分割窗口
" }

" buffer {
  nnoremap <Leader>bp :bprevious<CR>
  nnoremap <Leader>bn :bnext<CR>
  nnoremap <Leader>bf :bfirst<CR>
  nnoremap <Leader>bl :blast<CR>
  nnoremap <Leader>bd :bd<CR>
  nnoremap <Leader>bk :bw<CR>
" }
