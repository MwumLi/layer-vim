" vi: set ft=vim :
"
" Project custom configurations for layer-vim
" You can enable the existing layers in layer-vim and
" exclude the partial plugins in a certain layer.
" The command Layer and Exlcude are vaild in the function ProjectLayers().

" Put your pre-global-varible and vim configurations before plugins
" Override UserInit ()
function! ProjectInit()

    " Space has been set as the default leader key,
    " if you want to change it, uncomment and set it here.
    " let g:layervim_leader = "\<Space>"
    " let g:layervim_localleader = ','

    " Set your project root project
    " Project vim configurations :
    "   cp ~/.layer-vim/example/project-layervim.vim youProjectRootPath/.layervim
    "let g:layervim_project_root = []

    " Space has been set as the default leader key,
    " if you want to change it, uncomment and set it here.
    " let g:layervim_leader = "\<Space>"
    " let g:layervim_localleader = ','

    " enable mouse
    " let g:layervim_better_default_enable_mouse = 1
    " use undo
    " let g:layervim_better_default_persistent_undo = 1
    " tas as 4 spaces
    " let g:layervim_better_default_tab_as_spaces = 4
    " default enable wrap
    " if didable wrap, uncomment it
    " let g:layervim_better_default_no_wrap = 1

    " Set your project root project
    " Project vim configurations :
    "   cp ~/.layer-vim/example/project-layervim.vim youProjectRootPath/.layervim
    "let g:layervim_project_root = []

endfunction

function! ProjectLayers()

    " Enable a certain topic
    " Topic '+layervim'

    " Exclude a certain topic
    " ETopic ''+layervim

    " Enable a certain layer
    " Layer 'fzf'

    " Exclude a certain layer
    " ELayer 'fzf'

    " Enable a certain vim plugin
    " Plugin 'extr0py/oni'

    " Exclude a certaine vim plugin
    " Exclude 'extr0py/oni'

endfunction

" Put your costom configurations here, e.g., change the colorscheme.
function! ProjectConfig()

    " If you enable airline layer and have installed the powerline fonts, set it here.
    " let g:airline_powerline_fonts=1
    " color desert

endfunction
