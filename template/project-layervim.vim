" You can enable the existing layers in layer-vim and
" exclude the partial plugins in a certain layer.
" The command Layer and Exlcude are vaild in the function ProjectLayers().
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
