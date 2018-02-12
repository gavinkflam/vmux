" Copyright (c) 2018 Gavin Lam. All rights reserved.
"
" This work is licensed under the terms of the MIT license.
" For a copy, see <https://opensource.org/licenses/MIT>.

" Exit when loaded already or compatible mode was set
if exists('g:loaded_vmux_plugin') || &cp
  finish
endif

let g:loaded_vmux_plugin = 1

" Section: Commands

" Command wrapper for dispatch
command! -nargs=1 VmuxDispatch call vmux#dispatch(<f-args>)

" Section: Key mappings

" Key mappings for dispatch
inoremap <silent> <Plug>(Vmux_dispatch) <C-O>:call vmux#dispatch_line()<CR>
nnoremap <silent> <Plug>(Vmux_dispatch) :call vmux#dispatch_line()<CR>
xnoremap <silent> <Plug>(Vmux_dispatch) :call vmux#dispatch_selection()<CR>gv
