" Copyright (c) 2018 Gavin Lam. All rights reserved.
"
" This work is licensed under the terms of the MIT license.
" For a copy, see <https://opensource.org/licenses/MIT>.

" Exit when loaded already or compatible mode was set
if exists('g:loaded_vmux') || &cp
  finish
endif

let g:loaded_vmux = 1

" Section: Exposed commands

" Execute payload in the companion pane via the tmux buffer
function! vmux#dispatch(payload)
  " Early exit if not in tmux session
  if $TMUX == ''
    echom 'You are not in a tmux session'
    return
  endif

  " Early exit if there is only one pane
  if system('tmux display-message -p -F "#{window_panes}"') == 1
    echom 'There is only one pane in the current window'
    return
  endif

  " Load argument into tmux buffer, then paste at companion pane and send return
  silent! call system('tmux loadb -', a:payload)
  silent! call system('tmux pasteb -t +')
  silent! call system('tmux send-keys -t + C-m')
endfunction

" Operation mode
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

function! vmux#dispatch_line()
  call vmux#dispatch(getline('.'))
endfunction

function! vmux#dispatch_visual()
  call vmux#dispatch_op(visualmode(), 1)
endfunction
