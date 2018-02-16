# Vmux

REPL anything! Dispatch commands to tmux companion pane without changing focus.

## Install

Use your favourite plugin manager to install Vmux.

If you don't have an idea, I recommend [vim-plug](https://github.com/junegunn/vim-plug).

```vim
Plug 'gavinkflam/vmux'
```

## Quick Start

Add the following mappings to your .vimrc.

```vim
" Dispatch selection to companion pane (e.g. vipg,)
xmap g,    <Plug>(Vmux_dispatch)

" Start Vmux for a motion / text object (e.g. g,ip)
nmap g,    <Plug>(Vmux_dispatch_op)

" Dispatch current line to companion pane
imap <M-,> <Plug>(Vmux_dispatch)
nmap g,,   <Plug>(Vmux_dispatch)
```

## Other Useful Commands

`:VmuxClearPane` clear outputs of the companion pane by sending ctrl-L key
sequence.

`:VmuxKillPane` kills the companion pane via tmux `kill-pane` command.

`:VmuxDispatchLast` dispatch the last command to the companion pane.

## repeat.vim support

`g,`, `g,,` and `Alt-,` works with
[repeat.vim](https://github.com/tpope/vim-repeat) if you have it installed.

## Roadmap

- Add screencasts
- Add Vader test scripts
- Add Travis CI scripts

## License

MIT
