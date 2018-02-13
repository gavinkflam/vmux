# Vmux

REPL anything! Dispatch commands to tmux companion pane with just two clicks.

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
nmap g,    <Plug>(Vmux_dispatch)

" Dispatch current line to companion pane
imap <M-,> <Plug>(Vmux_dispatch)
nmap g,,   <Plug>(Vmux_dispatch_line)
```

## Roadmap

- Implement companion window orchestration
- Implement dispatching of last command
- Implement repeat.vim support
- Add screencasts
- Work on Vader tests
- Run tests on Travis CI

## License

MIT
