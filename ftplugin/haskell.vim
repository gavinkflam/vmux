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

" GHCi command
if executable('stack')
  " Use stack GHCi if applicable
  command! -nargs=* VmuxGhci :exec 'VmuxDispatch stack ghci ' . <q-args>
else
  " Ordinary GHCi
  command! -nargs=* VmuxGhci :exec 'VmuxDispatch ghci ' . <q-args>
endif

" Simple commands
command! -nargs=0 VmuxGhciReload       :VmuxDispatch :reload
command! -nargs=* VmuxGhciShell        :exec 'VmuxDispatch :! ' . <q-args>
command! -nargs=* VmuxGhciShow         :exec 'VmuxDispatch :show ' . <q-args>
command! -nargs=0 VmuxGhciShowBindings :VmuxGhciShow bindings
command! -nargs=0 VmuxGhciShowModules  :VmuxGhciShow modules
command! -nargs=0 VmuxGhciQuit         :VmuxDispatch :quit

" Set and unset commands
command! -nargs=* VmuxGhciSet          :exec 'VmuxDispatch :set ' . <q-args>
command! -nargs=* VmuxGhciUnset        :exec 'VmuxDispatch :unset ' . <q-args>

" Add and load commands
command! -nargs=* VmuxGhciAdd          :exec 'VmuxDispatch :add ' . <q-args>
command! -nargs=0 VmuxGhciAddFile      :exec 'VmuxGhciAdd ' . @%
command! -nargs=* VmuxGhciLoad         :exec 'VmuxDispatch :load ' . <q-args>
command! -nargs=0 VmuxGhciLoadFile     :exec 'VmuxGhciLoad ' . @%

" Browse commands
command! -nargs=* VmuxGhciBrowse       :exec 'VmuxDispatch :browse ' . <q-args>
command! -nargs=0 VmuxGhciBrowseWord   :exec 'VmuxGhciBrowse ' . expand("<cWORD>")

" Info commands
command! -nargs=* VmuxGhciInfo         :exec 'VmuxDispatch :info ' . <q-args>
command! -nargs=0 VmuxGhciInfoWord     :exec 'VmuxGhciInfo ' . expand("<cWORD>")

" Type commands
command! -nargs=* VmuxGhciType         :exec 'VmuxDispatch :type ' . <q-args>
command! -nargs=0 VmuxGhciTypeIt       :VmuxGhciType it
command! -nargs=0 VmuxGhciTypeWord     :exec 'VmuxGhciType ' . expand("<cWORD>")

" Stack commands via shell
command! -nargs=0 VmuxGhciStackTargets :VmuxGhciShell stack ide targets
command! -nargs=* VmuxGhciStackBuild   :exec 'VmuxGhciShell stack build ' . <q-args>
command! -nargs=0 VmuxGhciStackTest    :VmuxGhciStackBuild --test
