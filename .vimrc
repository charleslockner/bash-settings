" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Cool status bar at bottom
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Autodetect tab spacing
Plug 'tpope/vim-sleuth'
" VSCODE-like auto-completion + realtime error showing
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Initialize plugin system
call plug#end()

" ------------------- AIRLINE CONFIGURATION -------------------
" air-line fallback font path
" https://vi.stackexchange.com/questions/3359/how-do-i-fix-the-status-bar-symbols-in-the-airline-plugin
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.colnr = '㏇'
let g:airline_symbols.colnr = '℅'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" ------------------- COC CONFIGURATION -------------------
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ ]

" ------------------- ACTUAL START OF CONFIGURATION -------------------
let g:airline_theme='apprentice'

"colorscheme evening
highlight Visual cterm=reverse ctermbg=NONE
set number
set relativenumber
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list
" ESC + j does crazy things if this is not here: https://github.com/neovim/neovim/issues/2017
set ttimeoutlen=-1
" vimrc file from youtuber: https://gist.github.com/benawad/b768f5a5bbd92c8baabd363b7e79786f

