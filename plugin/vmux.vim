" Command wrapper for dispatch
command! -nargs=1 VmuxDispatch call vmux#dispatch(<f-args>)

" Key mappings for dispatch
inoremap <silent> <Plug>(Vmux_dispatch) <C-O>:call vmux#dispatch_line()<CR>
nnoremap <silent> <Plug>(Vmux_dispatch) :call vmux#dispatch_line()<CR>
xnoremap <silent> <Plug>(Vmux_dispatch) :call vmux#dispatch_selection()<CR>gv
