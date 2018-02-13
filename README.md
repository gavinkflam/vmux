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

## Roadmap

- Add screencasts
- Add Vader test scripts
- Add Travis CI scripts

## License

MIT
