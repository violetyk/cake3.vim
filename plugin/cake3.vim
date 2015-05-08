if exists('g:loaded_cake3_vim')
  finish
endif
let g:loaded_cake3_vim = 1

let s:save_cpo = &cpo
set cpo&vim

call cake3#register_commands()

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set fenc=utf-8 ff=unix ft=vim fdm=marker:
