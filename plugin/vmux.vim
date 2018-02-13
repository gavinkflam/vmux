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
command! -nargs=1 VmuxDispatch        call vmux#dispatch(<f-args>)
command! -nargs=0 VmuxDispatchLast    call vmux#dispatch_last()

" Command wrapper for companion pane orchestration
command! -nargs=0 VmuxKillPane        call vmux#kill_pane()
command! -nargs=0 VmuxClearPane       call vmux#clear_pane()

" Section: Key mappings

" Key mappings for dispatch
inoremap <silent> <Plug>(Vmux_dispatch) <C-O>:call vmux#dispatch_line()<CR>
nnoremap <silent> <Plug>(Vmux_dispatch_op) :set opfunc=vmux#dispatch_op<CR>g@
nnoremap <silent> <Plug>(Vmux_dispatch) :call vmux#dispatch_line()<CR>
vnoremap <silent> <Plug>(Vmux_dispatch) :<C-U>call vmux#dispatch_visual()<CR>

" Key mappings for dispatch_last
inoremap <silent> <Plug>(Vmux_dispatch_last) :call vmux#dispatch_last()<CR>
nnoremap <silent> <Plug>(Vmux_dispatch_last) :call vmux#dispatch_last()<CR>
vnoremap <silent> <Plug>(Vmux_dispatch_last) :call vmux#dispatch_last()<CR>
