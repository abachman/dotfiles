"GVIM Configuration, mostly look and feel.

set guiheadroom=0 " get as tall as possible.
" Turn off useless toolbar
set guioptions-=T
" Turn off menu bar (toggle with CTRL+F11)
set guioptions-=m
" Turn off right-hand scroll-bar (toggle with CTRL+F7)
set guioptions-=r
set guioptions-=l
" CTRL+F11 to toggle the menu bar
nmap <C-F11> :if &guioptions=~'m' \| set guioptions-=m \| else \| set guioptions+=m \| endif<CR>
" CTRL+F7 to toggle the right-hand scroll bar
nmap <C-F7> :if &guioptions=~'r' \| set guioptions-=r \| else \| set guioptions+=r \| endif<CR>

set gfn=Terminus\ 9
" set gfn=Inconsolata\ 16

"colorscheme railscasts
"colorscheme vividchalk
colorscheme desert
