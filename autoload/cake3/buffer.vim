let s:save_cpo = &cpo
set cpo&vim

function! cake3#buffer#open(split_type, path, line)

  " current window
  if cake3#buffer#is_window_usable(winnr())
    call s:open(a:path, a:split_type, a:line)
    return
  endif

  " previous window
  if cake3#buffer#is_window_usable(winnr("#"))
    execute winnr('#'). 'wincmd w'
    call s:open(a:path, a:split_type, a:line)
    return
  endif

  " find usable window
  let winnr = cake3#buffer#find_usable_window()
  if winnr != -1
    execute winnr . 'wincmd w'
    call s:open(a:path, a:split_type, a:line)
    return
  endif
endfunction

function! cake3#buffer#setvar(expr, name, value)
  if strlen(bufname(a:expr))
    call setbufvar(bufname(a:expr), a:name, a:value)
  endif
endfunction

function! cake3#buffer#getvar(expr, name)
  if strlen(bufname(a:expr))
    let bufvar = getbufvar(bufname(a:expr), a:name)
    if !empty(bufvar)
      return bufvar
    endif
  endif
  return {}
endfunction

function! cake3#buffer#in_windows(bufnr)
  let found_count = 0
  let winnr = 1

  " scan all windows
  while 1
    let bufnr = winbufnr(winnr)

    " scanning completion
    if bufnr == -1
      break
    endif

    if bufnr == a:bufnr
      let found_count = found_count + 1
    endif

    " next window
    let winnr = winnr + 1

  endwhile

  return found_count
endfunction

function! cake3#buffer#is_window_usable(winnr)
  " let window_count = winnr('$')
  " if window_count ==# 1 " last window
    " return 0
  " endif

  " get status of window
  let bufnr = winbufnr(a:winnr)
  if bufnr == -1
    return 0
  endif
  let is_special  = getbufvar(bufnr, '&buftype') != '' || getwinvar(a:winnr, '&previewwindow')
  let is_modified = getbufvar(bufnr, '&modified')

  if is_special
    return 0
  endif

  " It can be switched to the buffer even if a buffer not saved.
  if &hidden
    return 1
  endif

  if is_modified
    return 0
  endif

  if cake3#buffer#in_windows(winbufnr(a:winnr)) >= 2
    return 1
  endif
endfunction

function! cake3#buffer#find_usable_window()
  let i = 1

  while i <= winnr('$')
    if cake3#buffer#is_window_usable(i)
      return i
    endif
    let i += 1
  endwhile

  " Not found
  return -1
endfunction

function! s:open(path, split_type, line)
  if !bufexists(a:path)
    exec "badd " . a:path
  endif

  let buf_no = bufnr(a:path)
  if buf_no != -1
    if a:split_type == 's'      " horizontal plit
      exec "sb" . buf_no
    elseif a:split_type == 'v'  " vertical split
      exec "vert sb" . buf_no
    elseif a:split_type == 't'  " tab
      exec "tabedit"
      exec "b" . buf_no
    else                    " current
      exec "b" . buf_no
    endif

    if type(a:line) == type(0) && a:line > 0
      exec a:line
      exec "normal! z\<CR>"
      exec "normal! ^"
    endif
  endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set fenc=utf-8 ff=unix ft=vim fdm=marker:
