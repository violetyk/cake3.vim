let s:save_cpo = &cpo
set cpo&vim

function! cake3#path#app() abort
  " search config/app.php, config/bootstrap.php, src/.
  " the first is current buffer, next `pwd`.
  let dirs = [
        \ escape(expand("%:p:h"), ' \') . ';',
        \ escape(fnamemodify('.', ':p'), ' \') . ';',
        \ ]

  for path_config in finddir('config', join(dirs, ','), -1)
    if filereadable(path_config . '/app.php')
          \ && filereadable(path_config . '/bootstrap.php')
          \ && isdirectory(path_config . '/../src/')
      return fnamemodify(path_config, ':h')
    endif
  endfor

  " not found.
  return ''
endfunction

" return a string '/path/to/src/Controller/,/path/to/othoer/Controller/'
function! cake3#path#controller() abort
  let dirs = []

  " app
  let path_app = cake3#path#app()
  if strlen(path_app)
    call add(dirs, path_app . '/src/Controller/')
  endif

  " TODO: append path from .cake

  return join(dirs, ',')
endfunction


function! cake3#path#entity() abort
  let dirs = []

  " app
  let path_app = cake3#path#app()
  if strlen(path_app)
    call add(dirs, path_app . '/src/Model/Entity/')
  endif

  " TODO: append path from .cake

  return join(dirs, ',')
endfunction

function! cake3#path#table() abort
  let dirs = []

  " app
  let path_app = cake3#path#app()
  if strlen(path_app)
    call add(dirs, path_app . '/src/Model/Table/')
  endif

  " TODO: append path from .cake

  return join(dirs, ',')
endfunction

function! cake3#path#template() abort
  let dirs = []

  " app
  let path_app = cake3#path#app()
  if strlen(path_app)
    call add(dirs, path_app . '/src/Template/')
  endif

  " TODO: append path from .cake

  return join(dirs, ',')
endfunction


function! cake3#path#to_name_controller(path) abort
  return substitute(fnamemodify(a:path, ':t:r'), 'Controller$', '', '')
endfunction

function! cake3#path#to_name_entity(path) abort
  return fnamemodify(a:path, ':t:r')
endfunction

function! cake3#path#to_name_table(path) abort
  return substitute(fnamemodify(a:path, ':t:r'), 'Table$', '', '')
endfunction

function! cake3#path#to_name_template(path) abort
  return fnamemodify(substitute(a:path, cake3#path#template(), '', ''), ':r')
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set fenc=utf-8 ff=unix ft=vim fdm=marker:
