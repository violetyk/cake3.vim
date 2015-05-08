let s:save_cpo = &cpo
set cpo&vim


function! cake3#navigator#go_to_controller(split_type, ...) abort
  let targets = a:000
  let controllers = cake3#get_controllers()
  for name in targets
    if has_key(controllers, name)
      call cake3#buffer#open(a:split_type, controllers[name], 0)
    endif
  endfor
endfunction

function! cake3#navigator#go_to_entity(split_type, ...) abort
  let targets = a:000
  let entities = cake3#get_entities()
  for name in targets
    if has_key(entities, name)
      call cake3#buffer#open(a:split_type, entities[name], 0)
    endif
  endfor
endfunction

function! cake3#navigator#go_to_table(split_type, ...) abort
  let targets = a:000
  let tables = cake3#get_tables()
  for name in targets
    if has_key(tables, name)
      call cake3#buffer#open(a:split_type, tables[name], 0)
    endif
  endfor
endfunction

function! cake3#navigator#go_to_template(split_type, ...) abort
  let targets = a:000
  let templates = cake3#get_templates()
  for name in targets
    if has_key(templates, name)
      call cake3#buffer#open(a:split_type, templates[name], 0)
    endif
  endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim:set fenc=utf-8 ff=unix ft=vim fdm=marker:
