" User custom configurations for layer-vim
" You can enable the existing layers in layer-vim and
" exclude the partial plugins in a certain layer.
" The command Layer and Exlcude are vaild in the function UserLayers().
function! UserLayers()

    " Command Layer to enable a certain layer
    " Layer 'fzf'

    " Default layers, recommended!
    Layer 'fzf'
    Layer 'unite'
    Layer 'better-defaults'

    "Command Exclude to disable the partial plugins in a certain layer
    " Exclude 'extr0py/oni'

endfunction

" Put your private plugins here.
function! UserInit()

    " Space has been set as the default leader key,
    " if you want to change it, uncomment and set it here.
    " let g:layervim_leader = "<\Space>"
    " let g:layervim_localleader = ','

	" Set your project root project
    " Project vim configurations :
    "   cp ~/.layer-vim/example/project-layervim.vim youProjectRootPath/.layervim
	let g:layervim_project_root = []

    " Install private plugins
    " Plug 'extr0py/oni'

endfunction

" Put your costom configurations here, e.g., change the colorscheme.
function! UserConfig()

    " If you enable airline layer and have installed the powerline fonts, set it here.
    " let g:airline_powerline_fonts=1
    " color desert

endfunction
