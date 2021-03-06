"   _                                 _
"  | | __ _ _   _  ___ _ __    __   _(_)_ __ ___
"  | |/ _` | | | |/ _ \ '__|___\ \ / / | '_ ` _ \
"  | | (_| | |_| |  __/ | |_____\ V /| | | | | | |
"  |_|\__,_|\__, |\___|_|        \_/ |_|_| |_| |_|
"           |___/
"
"   Copyright (c) 2016 MwumLi & Contributors
"
"   You can customize layer-vim with .layervim
"   and don't have to take care of this file.
"
"   Author: MwumLi <mwumli@gmail.com>
"   URL: https://github.com/MwumLi/layer-vim
"   License: Apache

scriptencoding utf-8

" Identify platform {
let g:MAC = has('macunix')
let g:LINUX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = has('win32') || has('win64')
" }

" Windows Compatible {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if g:WINDOWS
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
" }

let g:layervim_dir = $HOME.'/.layer-vim'
let g:layervim_core_dir = '/core'
let g:layervim_version = '1.0.0'

set runtimepath+=$HOME/.layer-vim/core

" load public global function from lib
execute "source " . g:layervim_dir . '/lib/functions.vim'

call layervim_core#begin()

call layervim_core#end()
