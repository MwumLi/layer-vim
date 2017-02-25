" judge whether end_str is the suffix of string str
function! EndsWith(str, end_str)
    let l:end_position = strridx(a:str, a:end_str) + strlen(a:end_str)
    let l:len = strlen(a:str)
    return l:end_position == l:len
endfunction

" judge whether end_str is the prefix of string str
function! StartsWith(str, start_str)
    let l:start_index = strridx(a:str, a:start_str)
    return l:start_index == 0
endfunction

" get partial string from start of str, which length is len
function! StrPart(str, start, len)
    if exists('*strcharpart')
        return strcharpart(a:str, a:start, a:len)
    elseif exists('*strpart')
        return strpart(a:str, a:start, a:len)
    endif
endfunction

function! PathResolve(...)
    let l:real_path = ''
    for l:path in a:000
        if EndsWith(l:path, '/')
            let l:path = StrPart(l:path, 0, strridx(l:path, '/'))
        end
        let l:real_path = l:real_path . l:path . '/'
    endfor

    if a:0 > 0 && EndsWith(l:real_path, '/')
        let l:real_path = StrPart(l:real_path, 0, strridx(l:real_path, '/'))
    end
    return l:real_path
endfunction

" source file
function! Source(file) abort
    if filereadable(expand(a:file))
        execute 'source ' . fnameescape(a:file)
        return 1
    endif
    return 0
endfunction

" list to string
function! List2String(list)
    let str = ''
    for i in a:list
        let str .= i
    endfor
    return str
endfunction

let s:TYPE = {
\   'string':  type(''),
\   'list':    type([]),
\   'dict':    type({}),
\   'funcref': type(function('call'))
\ }

function! IsDict(v)
  return type(a:v) == s:TYPE.dict
endfunction

function! IsList(v)
  return type(a:v) == s:TYPE.list
endfunction

function! IsString(v)
  return type(a:v) == s:TYPE.string
endfunction

function IsFunc(v)
  return type(a:v) == s:TYPE.funcref
endfunction
