" Copyright (c) 2018 Gavin Lam. All rights reserved.
"
" This work is licensed under the terms of the MIT license.
" For a copy, see <https://opensource.org/licenses/MIT>.

" Exit when loaded already or compatible mode was set
if exists('g:loaded_vmux') || &cp
  finish
endif

let g:loaded_vmux = 1

" Section: Configuration items

" Utility function to load configuration item or apply default if not defined
function! s:load_config_item(name, default)
  if !exists(a:name)
    exec 'let ' . a:name . ' = ' .
      \ "'" . substitute(a:default, "'", "''", "g") . "'"
    return 1
  endif
  return 0
endfunction

" Argument for spawning companion pane with tmux split-window
call s:load_config_item(
  \ "g:vmux_companion_pane_arguments", '-h -d -p 30 -c "#{pane_current_path}"'
\ )

" Section: Utility functions

" Function to check if runtime is in a tmux session, error message will be
" printed if otherwise
function! s:is_in_tmux()
  if $TMUX == ''
    echom 'You are not in a tmux session'
    return 0
  endif
  return 1
endfunction

" Check if the companion pane exists
function! s:companion_pane_exists()
  return system('tmux display-message -p -F "#{window_panes}"') != 1
endfunction

" Check if the window is zoomed
function! s:window_zoomed()
  return system('tmux display-message -p -F "#{window_zoomed_flag}"') == 1
endfunction

" Toogle zoom state of the current pane
function! s:toggle_zoom_state()
  call system('tmux resize-pane -Z ')
  return 1
endfunction

" Spawn a companion pane with arguments configuration item,
" without checking if runtime is in a tmux session or a companion pane exists
function! s:spawn_companion_pane_unsafe()
  call system('tmux split-window ' . g:vmux_companion_pane_arguments)
  return 1
endfunction

" Ensure a companion pane exists visible, or otherwise spawn a companion pane
" and/or exit the zoomed state
function! s:ensure_companion_pane_presents()
  if !s:companion_pane_exists()
    call s:spawn_companion_pane_unsafe()
  endif

  if s:window_zoomed()
    call s:toggle_zoom_state()
  endif

  return 1
endfunction

" Ensure a companion pane is present and visible
function! s:bring_companion_pane()
  " Early exit if not in tmux session
  if !s:is_in_tmux()
    return 0
  endif

  " Delegate to ensure companion pane presents utility function
  return s:ensure_companion_pane_presents()
endfunction

" Section: Exposed commands

" Execute payload in the companion pane via the tmux buffer
function! vmux#dispatch(payload)
  " Bring up comapnion pane first, or otherwise eartly exit
  if !s:bring_companion_pane()
    return 0
  endif

  " Load argument into tmux buffer, then paste at companion pane
  silent! call system('tmux loadb -', a:payload)
  silent! call system('tmux pasteb -t +')

  " Send carriage return only if the last character is not a newline
  if strridx(a:payload, "\n") != (strlen(a:payload) - 1)
    silent! call system('tmux send-keys -t + C-m')
  endif

  " Save last dispatched payload
  let s:last_dispatched_payload = a:payload

  " Register repeat.vim command
  silent! call repeat#set("\<Plug>(Vmux_dispatch_last)")
endfunction

" Dispatch last dispatched payload
function! vmux#dispatch_last()
  if exists('s:last_dispatched_payload')
    call vmux#dispatch(s:last_dispatched_payload)
  else
    echom 'No command has been dispatched'
  endif
endfunction

" Operation mode to be used with a motion / text object
function! vmux#dispatch_op(type, ...)
  " Save selection and register state
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0
    " Invoked from Visual mode, use gv command
    silent exe "normal! gvy"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  else
    silent exe "normal! `[v`]y"
  endif

  " Invoke dispatch with content of register
  call vmux#dispatch(@@)

  " Restore saved state
  let &selection = sel_save
  let @@ = reg_save
endfunction

" Dispatch content under the current line
function! vmux#dispatch_line()
  call vmux#dispatch(getline('.'))
endfunction

" Dispatch visual mode selection via operation mode
function! vmux#dispatch_visual()
  call vmux#dispatch_op(visualmode(), 1)
endfunction
