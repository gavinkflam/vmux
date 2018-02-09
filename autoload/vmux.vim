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

function! vmux#dispatch_line()
  call vmux#dispatch(getline('.'))
endfunction

function! vmux#dispatch_selection()
  call vmux#dispatch(s:get_visual_selection())
endfunction

" Section: Utility functions

" Get text under visual selection
" https://github.com/erig0/nc2xclip/blob/master/get_visual_selection.vim
function! s:get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - 1]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction
