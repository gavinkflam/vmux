" Copyright (c) 2018 Gavin Lam. All rights reserved.
"
" This work is licensed under the terms of the MIT license.
" For a copy, see <https://opensource.org/licenses/MIT>.

" Exit when loaded already or compatible mode was set
if exists('g:loaded_vmux_ftplugin_haskell') || &cp
  finish
endif

let g:loaded_vmux_ftplugin_haskell = 1

" Section: Commands

if executable('stack')
  " Use stack to execute ghci if applicable
  command! -nargs=0 Ghci              :VmuxDispatch stack exec ghci
else
  " Ordinary ghci
  command! -nargs=0 Ghci              :VmuxDispatch ghci
endif

" ghci related commands
command! -nargs=0 GhciLoad          :exec 'VmuxDispatch :load ' . @%
command! -nargs=0 GhciInfo          :exec 'VmuxDispatch :info ' . @%
command! -nargs=0 GhciReload        :VmuxDispatch :reload
command! -nargs=0 GhciShowBindings  :VmuxDispatch :show bindings
command! -nargs=0 GhciShowModules   :VmuxDispatch :show modules
command! -nargs=* GhciType          :exec 'VmuxDispatch :type ' . <q-args>
command! -nargs=0 GhciQuit          :VmuxDispatch :quit
