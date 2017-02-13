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
    let g:layervim_project_root = []

endfunction

function! ProjectLayers()

    " Command Layer to enable a certain layer
    " Layer 'fzf'

    "Command Exclude to disable the partial plugins in a certain layer
    " Exclude 'extr0py/oni'

endfunction

" Put your costom configurations here, e.g., change the colorscheme.
function! ProjectConfig()

    " If you enable airline layer and have installed the powerline fonts, set it here.
    " let g:airline_powerline_fonts=1
    " color desert

endfunction
