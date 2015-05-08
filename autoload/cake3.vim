let s:save_cpo = &cpo
set cpo&vim


function! cake3#register_commands() abort
  " controller
  command! -n=* -complete=customlist,cake3#complete_controller Ccontroller
        \ call cake3#navigator#go_to_controller('n', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_controller CScontroller
        \ call cake3#navigator#go_to_controller('s', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_controller CVcontroller
        \ call cake3#navigator#go_to_controller('v', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_controller CTcontroller
        \ call cake3#navigator#go_to_controller('t', <f-args>)

  " entity
  command! -n=* -complete=customlist,cake3#complete_entity Centity
        \ call cake3#navigator#go_to_entity('n', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_entity CSentity
        \ call cake3#navigator#go_to_entity('s', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_entity CVentity
        \ call cake3#navigator#go_to_entity('v', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_entity CTentity
        \ call cake3#navigator#go_to_entity('t', <f-args>)

  " table
  command! -n=* -complete=customlist,cake3#complete_table Ctable
        \ call cake3#navigator#go_to_table('n', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_table CStable
        \ call cake3#navigator#go_to_table('s', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_table CVtable
        \ call cake3#navigator#go_to_table('v', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_table CTtable
        \ call cake3#navigator#go_to_table('t', <f-args>)

  " template
  command! -n=* -complete=customlist,cake3#complete_template Ctemplate
        \ call cake3#navigator#go_to_template('n', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_template CStemplate
        \ call cake3#navigator#go_to_template('s', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_template CVtemplate
        \ call cake3#navigator#go_to_template('v', <f-args>)
  command! -n=* -complete=customlist,cake3#complete_template CTtemplate
        \ call cake3#navigator#go_to_template('t', <f-args>)

endfunction


function! cake3#filter_candidates(list, word) abort
  return filter(a:list, 'v:val =~ "^'. fnameescape(a:word) . '"')
endfunction

function! cake3#complete_controller(ArgLead, CmdLine, CursorPos) abort
  return cake3#filter_candidates(sort(keys(cake3#get_controllers())), a:ArgLead)
endfunction

function! cake3#complete_entity(ArgLead, CmdLine, CursorPos) abort
  return cake3#filter_candidates(sort(keys(cake3#get_entities())), a:ArgLead)
endfunction

function! cake3#complete_table(ArgLead, CmdLine, CursorPos) abort
  return cake3#filter_candidates(sort(keys(cake3#get_tables())), a:ArgLead)
endfunction

function! cake3#complete_template(ArgLead, CmdLine, CursorPos) abort
  return cake3#filter_candidates(sort(keys(cake3#get_templates())), a:ArgLead)
endfunction


function! cake3#get_controllers() abort
  let dict = {}

  for path in split(globpath(cake3#path#controller(), '**/*Controller\.php'), '\n')
    let dict[cake3#path#to_name_controller(path)] = path
  endfor

  return dict
endfunction

function! cake3#get_entities() abort
  let dict = {}

  for path in split(globpath(cake3#path#entity(), '**/*\.php'), '\n')
    let dict[cake3#path#to_name_entity(path)] = path
  endfor

  return dict
endfunction

function! cake3#get_tables() abort
  let dict = {}

  for path in split(globpath(cake3#path#table(), '**/*Table\.php'), '\n')
    let dict[cake3#path#to_name_table(path)] = path
  endfor

  return dict
endfunction

function! cake3#get_templates() abort
  let dict = {}

  for path in split(globpath(cake3#path#template(), '**/*\.ctp'), '\n')
    let dict[cake3#path#to_name_template(path)] = path
  endfor

  return dict
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set fenc=utf-8 ff=unix ft=vim fdm=marker:
