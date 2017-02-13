if has('autocmd')
augroup LAYERVIM_BASIC
  autocmd!

  " Restore cursor position when opening file
  autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g'\"" |
                \ endif

  autocmd BufEnter * call MyLastWindow()
  function! MyLastWindow()
      " if the window is quickfix/locationlist go on
      if &buftype ==# 'quickfix' || &buftype ==# 'locationlist'
          " if this window is last on screen quit without warning
          if winbufnr(2) == -1
              quit!
          endif
      endif
  endfunction

  autocmd BufReadPre *
                \   if getfsize(expand("%")) > 10000000 |
                \   syntax off |
                \   endif

  autocmd Filetype markdown set noexpandtab
augroup END
endif
