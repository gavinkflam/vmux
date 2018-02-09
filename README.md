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
" Dispatch current line to companion pane
imap <M-,> <Plug>(Vmux_dispatch)
nmap ,, <Plug>(Vmux_dispatch)

" Dispatch selection to companion pane
xmap ,, <Plug>(Vmux_dispatch)
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
