" vi: set ft=vim :
"
" User custom configurations for layer-vim
" You can enable the existing layers in layer-vim and
" exclude the partial plugins in a certain layer.
" The command Layer and Exlcude are vaild in the function UserLayers().

" Put your pre-global-varibal and vim configurations before plugins
function! UserInit()

    " Space has been set as the default leader key,
    " if you want to change it, uncomment and set it here.
    " let g:layervim_leader = "\<Space>"
    " let g:layervim_localleader = ','

    " enable mouse
    let g:layervim_better_default_enable_mouse = 1
    " use undo
    let g:layervim_better_default_persistent_undo = 1
    " tas as 4 spaces
    let g:layervim_better_default_tab_as_spaces = 4
    " default enable wrap
    " if didable wrap, uncomment it
    " let g:layervim_better_default_no_wrap = 1

    " Set your project root project
    " Project vim configurations :
    "   cp ~/.layer-vim/example/project-layervim.vim youProjectRootPath/.layervim
    let g:layervim_project_root = []

endfunction

function! UserLayers()

    " Default to load topic : '+layervim'
    Topic '+layervim'

    " Command Layer to enable a certain layer
    " Layer 'fzf'

    "Command Exclude to disable the partial plugins in a certain layer
    " Exclude 'extr0py/oni'

    " Install private plugins
    " Plug 'extr0py/oni'

endfunction


" Put your costom configurations here, e.g., change the colorscheme.
function! UserConfig()

    " If you enable airline layer and have installed the powerline fonts, set it here.
    " let g:airline_powerline_fonts=1
    " color desert

endfunction
