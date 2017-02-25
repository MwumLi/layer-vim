" ********Begin**** Define Script variable and global variabl
let s:layervim_layers_dir = PathResolve(g:layervim_dir, 'layers')
if exists("$LAYERVIM_LAYERS_PATH")
    let s:layervim_layers_dir = $LAYERVIM_LAYERS_PATH
endif

let s:dot_layervim = PathResolve($HOME, '.layervim')

let s:layervim_tab = get(s:, 'layervim_tab', -1)
let s:layervim_buf = get(s:, 'layervim_buf', -1)

let g:layervim_nvim = has('nvim') && exists('*jobwait') && !g:WINDOWS
let g:layervim_vim8 = has('patch-8.0.0039') && exists('*job_start')
let g:layervim_gui_running = has('gui_running')

let g:layers_loaded = []
let s:topics_loaded = []

" ********End**** Define Script variable and global variabl

" argument plugin is the vim plugin's name
function! layervim_core#IsDir(plugin) abort
    let l:plugin_path = PathResolve(g:layervim_plugin_path, a:plugin)
    if isdirectory(expand(l:plugin_path))
        return 1
    else
        return 0
    endif
endfunction

function! layervim_core#LayerLoaded(layer) abort
    if index(g:layers_loaded, a:layer) > -1
        return 1
    else
        return 0
    endif
endfunction

function! layervim_core#PluginLoaded(plugin) abort
    if index(s:layervim_plugins_key, a:plugin) > -1
        return 1
    else
        return 0
    endif
endfunction

silent function! s:source_echom(file) abort
    if filereadable(expand(a:file))
        execute 'source ' . fnameescape(a:file)
    else
        echom '[layer-vim] ' . a:file . ' does not exist, which may cause unexpected errors.'
    endif
endfunction

silent function! s:source(file) abort
    if filereadable(expand(a:file))
        execute 'source ' . fnameescape(a:file)
        return 1
    endif
    return 0
endfunction

" get the whole available layers number s:layers_sum, number
" get the topics s:topics, list
" get the pair topic to layers s:topic2layers, dict
function! s:collect_topics() abort

let py_exe = has('python') ? 'python' : 'python3'

execute py_exe "<< EOF"
# coding=utf-8
import os
import vim

# the directory include public layers and public topics
# public topic include some public layer, whihc aim to similar goal
topic_base = vim.eval('s:layervim_layers_dir')
topics = [f for f in os.listdir(topic_base) if os.path.isdir(os.path.join(topic_base,f)) and f.startswith('+')]
public_layers = [f for f in os.listdir(topic_base) if os.path.isdir(os.path.join(topic_base,f)) and not f.startswith('+') and not f.startswith('.')]
topic2layers = {}
layers_sum = 0;
layer_path = {}

# get pubic layer in ~/.layer_vim/layer, which named 'layer'
for l in public_layers:
    layers_sum += 1
    layer_path[l] = topic_base + '/' + l

# get topic layer in ~/.layer_vim/layer, which named '+topic/layer'
for t in topics:
    topic_path = topic_base + '/' + t
    layers = [f for f in os.listdir(topic_path) if os.path.isdir(os.path.join(topic_path,f))]
    layers_sum += len(layers)
    topic2layers[t] = layers
    for l in layers:
        layer_path[t+'/'+l] = topic_path + '/' + l

vim.command("let s:layers_sum = %d" % layers_sum)
vim.command("let s:topics = %s" % topics)
vim.command("let s:topic2layers = %s" % topic2layers)
vim.command("let g:layer_path = %s" % layer_path)
EOF

endfunction

call s:collect_topics()

function! s:err(msg)
    echohl ErrorMsg
    echom '[space-vim] '.a:msg
    echohl None
endfunction

function! s:warn(cmd, msg)
    echohl WarningMsg
    echom '[space-vim] '.a:msg
    echohl None
endfunction

function! s:check_vim_plug(plug_path)
    if empty(glob(a:plug_path))
        echo '==> Downloading vim-plug ......'
        execute '!curl -fLo ' . a:plug_path . ' --create-dirs ' .
                    \   'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    endif
endfunction

function! layervim_core#begin()

    let l:vim_plug_path = '~/.vim/autoload/plug.vim'
    let l:nvim_plug_path = '~/.local/share/nvim/site/autoload/plug.vim'

    " Download vim-plug if unavailable
    if g:layervim_nvim
        call s:check_vim_plug(l:nvim_plug_path)
    else
        call s:check_vim_plug(l:vim_plug_path)
    endif

    let s:vim_home = $HOME.'/.vim/'

    if !exists('g:layervim_plugin_path')
        if g:layervim_nvim
            " https://github.com/junegunn/vim-plug/issues/559
            let g:layervim_plugin_path = '~/.local/shared/nvim/plugged'
        else
            let g:layervim_plugin_path = PathResolve(s:vim_home, 'plugged')
        endif
    endif

    call plug#begin(g:layervim_plugin_path)

    call s:define_command()

endfunction

function! s:define_command()
    command! -nargs=+ -bar Topic call s:include_topic(<f-args>)
    command! -nargs=+ -bar ETopic call s:exclude_topic(<f-args>)

    command! -nargs=+ -bar Layer call s:include_layer(<f-args>)
    command! -nargs=+ -bar ELayer call s:exclude_layer(<f-args>)

    command! -nargs=+ -bar Plugin call s:include_plugin(<args>)
    command! -nargs=+ -bar EPlugin call s:exclude_plugin(<args>)

    command! -nargs=0 -bar LayerClean call s:layer_clean()
    command! -nargs=0 -bar LayerStatus call s:layer_status()
    command! -nargs=0 -bar LayerUpdate call s:layer_update()
    command! -nargs=0 -bar LayerInstall call s:layer_install()
endfunction

function! s:include_topic(...)
    if a:0 == 0
        return s:err('Argument missing: Topic name(s) required.')
    endif

    if a:0 == 1
        let l:topic_name = eval(a:1)
        if index(keys(s:topic2layers), l:topic_name) < 0 ||
                    \ index(s:topics_loaded, l:topic_name) >= 0
            return 0
        endif

        let l:topic_path = PathResolve(s:layervim_layers_dir, l:topic_name, 'topic.vim')
        " 如果自定义加载不满意,那么加载当前 Topic 中的所有 Layer
        if !Source(l:topic_path)
            let l:topic_layers = s:topic2layers[l:topic_name]
            for l:layer_name in l:topic_layers
                let l:cmd = "Layer '" . l:topic_name . '/' . l:layer_name . "'"
                execute l:cmd
            endfor
        endif
        call add(s:topics_loaded, l:topic_name)
        return 1
    endif

    call s:err('Options not supported now. Sorry for that.')
endfunction

function! s:exclude_topic(...)
    if a:0 == 0
        return s:err('Argument missing: Topic name(s) required.')
    endif

    if a:0 == 1
        let l:topic_name = eval(a:1)
        let l:index_topics_loaded = index(s:topics_loaded, l:topic_name)
        if has_key(s:topic2layers, l:topic_name) < 0 ||
                    \ l:index_topics_loaded < 0
            return 0
        endif

        let l:topic_layers = s:topic2layers[l:topic_name]
        for l:layer_name in l:topic_layers
            let l:cmd = "ELayer '" . l:topic_name . '/' . l:layer_name . "'"
            execute l:cmd
        endfor

        call remove(s:topics_loaded, l:index_topics_loaded)
        return 1
    endif

    call s:err('Options not supported now. Sorry for that.')
endfunction

function! s:include_layer(...)
    if a:0 == 0
        return s:err('Argument missing: layer name(s) required.')
    endif

    if a:0 == 1
        let l:layer = eval(a:1)

        if index(g:layers_loaded, l:layer) >= 0
            return 1
        endif

        return add(g:layers_loaded, l:layer)
    endif

    return s:err('Options not supported now. Sorry for that.')
endfunction

function! s:exclude_layer(...)
    if a:0 == 0
        return s:err('Argument missing: layer name(s) required.')
    endif

    if a:0 == 1
        let l:layer = eval(a:1)
        let l:index_layers_loaded = index(g:layers_loaded, l:layer)

        if l:index_layers_loaded < 0
            return 1
        endif

        return remove(g:layers_loaded, l:index_layers_loaded)
    endif

    return s:err('Options not supported now. Sorry for that.')
endfunction

" store all loaded plugins
let g:layervim_plugins = {}
function! s:include_plugin(plugin_name, ...)
  " override the same name plugin 
  if has_key(g:layervim_plugins, a:plugin_name) > 0
    let l:option = g:layervim_plugins[a:plugin_name]
  elseif a:0 > 0
    let l:option = a:1
  else 
    let l:option = {}
  endif
  let g:layervim_plugins[a:plugin_name] = a:0>0 ? a:1 : {}
endfunction

let g:layervim_excludes = []
function! s:exclude_plugin(name)
  if index(g:layervim_excludes, a:name) < 0
    call add(g:layervim_excludes, a:name)
  endif
endfunction

function! s:layer_install()
    execute 'PlugInstall'
endfunction

function! s:layer_update()
    execute 'PlugUpdate'
endfunction

function! s:layer_clean()
    execute 'PlugClean'
endfunction

function! s:new_window()
    execute get(g:, 'layervim_window', 'vertical topleft new')
endfunction

function! s:layervim_window_exists()
    let l:buflist = tabpagebuflist(s:layervim_tab)
    return !empty(l:buflist) && index(l:buflist, s:layervim_buf) >= 0
endfunction

function! s:assign_name()
    " Assign buffer name
    let l:prefix = '[Layers]'
    let l:name   = l:prefix
    let l:idx    = 2
    while bufexists(l:name)
        let l:name = printf('%s (%s)', l:prefix, l:idx)
        let l:idx = l:idx + 1
    endwhile
    silent! execute 'f' fnameescape(l:name)
endfunction

function! s:layer_status()
    call s:new_window()

    let b:layervim_preview = -1
    let s:layervim_tab = tabpagenr()
    let s:layervim_buf = winbufnr(0)
    call s:assign_name()

    let [l:cnt, l:total] = [0, len(g:layers_loaded)]

    call append(0, ['Enabled layers: ' . '(' . len(g:layers_loaded) . '/' . s:layers_sum . ')'])
    call setline(2, '[' . repeat('=', len(g:layers_loaded)) . ']')
    let l:inx = 3
    for l:layer in g:layers_loaded
        call setline(l:inx, '+ ' . l:layer)
        let l:inx = l:inx + 1
    endfor
    setlocal buftype=nofile bufhidden=wipe nobuflisted nolist noswapfile nowrap cursorline nomodifiable nospell
    setf layervim
    if exists('g:syntax_on')
        call s:syntax()
    endif
endfunction

function! s:syntax()
    syntax clear
    syntax region Layer1 start=/\%1l/ end=/\%2l/ contains=LayerNumber
    syntax region Layer2 start=/\%2l/ end=/\%3l/ contains=LayerBracket,LayerX
    syn match LayerNumber /[0-9]\+[0-9.]*/ contained
    syn match LayerBracket /[[\]]/ contained
    syn match LayerX /x/ contained
    syn match LayerDash /^-/
    syn match LayerPlus /^+/
    syn match LayerStar /^*/
    syn match LayerMessage /\(^- \)\@<=.*/
    syn match LayerName /\(^- \)\@<=[^ ]*:/
    syn match LayerInstall /\(^+ \)\@<=[^:]*/
    syn match LayerUpdate /\(^* \)\@<=[^:]*/
    syn match LayerNotLoaded /(not loaded)$/
    syn match LayerError /^x.*/
    syn region LayerDeleted start=/^\~ .*/ end=/^\ze\S/
    syn match LayerH2 /^.*:\n-\+$/
    syn keyword Function LayerInstall LayerStatus LayerUpdate LayerClean
    hi def link Layer1       Title
    hi def link Layer2       Repeat
    hi def link LayerH2      Type
    hi def link LayerX       Exception
    hi def link LayerBracket Structure
    hi def link LayerNumber  Number

    hi def link LayerDash    Special
    hi def link LayerPlus    Constant
    hi def link LayerStar    Boolean

    hi def link LayerMessage Function
    hi def link LayerName    Label
    hi def link LayerInstall Function
    hi def link LayerUpdate  Type

    hi def link LayerError   Error
    hi def link LayerDeleted Ignore

    hi def link LayerNotLoaded Comment
endfunction

function! s:check_dot_layervim()
    if filereadable(expand(s:dot_layervim))
        call s:source_echom(s:dot_layervim)
        return 1
    else
        echom '.layervim does not exist!!!'
        return 0
    endif
endfunction

function! s:check_project_dot_layervim()
    if exists('g:layervim_project_root')
        let l:cur_filepath = expand('%:p:h')
        for l:project_root in g:layervim_project_root
            let l:project_root = PathResolve(expand(l:project_root))
            let l:project_dot_layervim = PathResolve(l:project_root, '.layervim')
            if stridx(l:cur_filepath, l:project_root) == 0
                call s:source_echom(l:project_dot_layervim)
                return 1
            endif
        endfor
    endif
    return 0
endfunction

function! s:set_leader_and_localleader()
    if exists('g:layervim_leader')
        let g:mapleader=g:layervim_leader
    else
        let g:mapleader = "\<Space>"
    endif

    if exists('g:layervim_localleader')
        let g:maplocalleader=g:layervim_localleader
    else
        let g:maplocalleader = ','
    endif
endfunction

function! layervim_core#end()

    let l:dot_layervim_exist = s:check_dot_layervim()

    if l:dot_layervim_exist
        call UserInit()
    endif

    let l:project_dot_layervim_exist = s:check_project_dot_layervim()

    if l:project_dot_layervim_exist
        call ProjectInit()
    endif

    if l:dot_layervim_exist
        call UserLayers()
    endif

    if l:project_dot_layervim_exist
        call ProjectLayers()
    endif

    call s:load_layer_packages()

    call s:filter_and_invoke_plug()

    """""""""""""""""""""""""""""""""""""""
    " Plug ends.
    """""""""""""""""""""""""""""""""""""""
    call plug#end()

    call s:set_leader_and_localleader()

    " Make vim-better-default settings can be overrided
    " runtime! plugin/default.vim

    call s:load_layer_config()

    if l:dot_layervim_exist
        call UserConfig()
    endif

    if l:project_dot_layervim_exist
        call ProjectConfig()
    endif

    call s:post_user_config()

endfunction

function! s:load_layer_packages()
    let l:layers_loaded = []
    for l:layer in g:layers_loaded
        if has_key(g:layer_path, l:layer)
            let l:layer_packages = g:layer_path[l:layer] . '/packages.vim'
            call s:source_echom(l:layer_packages)
            call add(l:layers_loaded, l:layer)
        endif
    endfor
    let g:layers_loaded = l:layers_loaded
endfunction

function! s:filter_and_invoke_plug()
    for l:plugin in keys(g:layervim_plugins)
      if index(g:layervim_excludes, l:plugin) < 0
        let l:option = g:layervim_plugins[l:plugin]

        if IsString(l:option)
          Plug l:plugin, l:option
          continue
        endif

        if !IsDict(l:option)
          continue
        endif

        if empty(keys(l:option))
          Plug l:plugin
        else
          Plug l:plugin, l:option
        endif
      endif
    endfor
    let s:layervim_plugins_key = keys(g:layervim_plugins)
endfunction

function! s:load_layer_config()
    for l:layer in g:layers_loaded
        if has_key(g:layer_path, l:layer)
            let l:layer_config = g:layer_path[l:layer] . '/config.vim'
            call s:source_echom(l:layer_config)
        endif
    endfor
endfunction

function! s:statusline_hi()
    " default bg for statusline is 236 in space-vim-dark
    hi paste       cterm=bold ctermfg=149 ctermbg=239 gui=bold guifg=#99CC66 guibg=#3a3a3a
    hi ale_error   cterm=None ctermfg=197 ctermbg=237 gui=None guifg=#CC0033 guibg=#3a3a3a
    hi ale_warning cterm=None ctermfg=214 ctermbg=237 gui=None guifg=#FFFF66 guibg=#3a3a3a

    hi User1 cterm=bold ctermfg=232 ctermbg=179 gui=Bold guifg=#333300 guibg=#FFBF48
    hi User2 cterm=None ctermfg=214 ctermbg=243 gui=None guifg=#FFBB7D guibg=#666666
    hi User3 cterm=None ctermfg=251 ctermbg=241 gui=None guifg=#c6c6c6 guibg=#585858
    hi User4 cterm=Bold ctermfg=177 ctermbg=239 gui=Bold guifg=#d75fd7 guibg=#4e4e4e
    hi User5 cterm=None ctermfg=208 ctermbg=238 gui=None guifg=#ff8700 guibg=#3a3a3a
    hi User6 cterm=Bold ctermfg=178 ctermbg=237 gui=Bold guifg=#FFE920 guibg=#444444
    hi User7 cterm=None ctermfg=250 ctermbg=238 gui=None guifg=#bcbcbc guibg=#444444
    hi User8 cterm=None ctermfg=249 ctermbg=239 gui=None guifg=#b2b2b2 guibg=#4e4e4e
    hi User9 cterm=None ctermfg=249 ctermbg=241 gui=None guifg=#b2b2b2 guibg=#606060
endfunction

function! s:post_user_config()

    autocmd BufRead,BufNewFile *.layervim setlocal filetype=vim

    " airline
    if !exists('g:airline_powerline_fonts')

        let g:airline_left_sep=''
        let g:airline_right_sep=''

        let g:airline_symbols = {}
        let g:airline_symbols.linenr = '␊'
        let g:airline_symbols.linenr = '␤'
        let g:airline_symbols.linenr = '¶'
        let g:airline_symbols.branch = '⎇'
        let g:airline_symbols.paste = 'Þ'
        let g:airline_symbols.whitespace = 'Ξ'
    endif

    " User-defined highlightings shoule be put after colorscheme command.
    call s:statusline_hi()

    " https://github.com/junegunn/vim-plug/wiki/extra#automatically-install-missing-plugins-on-startup
    autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   echom '[space-vim]Some layers need to install the missing plugins first!'
      \|   PlugInstall --sync | q
      \| endif

endfunction
