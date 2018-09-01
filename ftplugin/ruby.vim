" Copyright (c) 2018 Gavin Lam. All rights reserved.
"
" This work is licensed under the terms of the MIT license.
" For a copy, see <https://opensource.org/licenses/MIT>.

" Exit when loaded already or compatible mode was set
if exists('g:loaded_vmux_ftplugin_ruby') || &cp
  finish
endif

let g:loaded_vmux_ftplugin_ruby = 1

" Section: Commands

" pry related commands
command! -nargs=0 Pry         :VmuxDispatch pry
command! -nargs=0 PryRemote   :VmuxDispatch pry-remote
command! -nargs=0 PryContinue :VmuxDispatch continue
command! -nargs=0 PryLoad     :exec 'VmuxDispatch load ''' . @% . ''''
command! -nargs=0 PryExit     :VmuxDispatch exit

" rake related commands
command! -nargs=0 RakeConsole :VmuxDispatch rake c
