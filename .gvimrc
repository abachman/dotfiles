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

if has("mac")
  set noeb vb t_vb=
  set gfn=Menlo:h12
  " set gfn=Terminus:h14
  " set gfn=Inconsolata:h14
else
  set gfn=Terminus\ 9
end

colorscheme base16-tomorrow-night

" key unbinding
if has("mac")
  macm File.New\ Tab key=<nop>
  macm File.Close key=<nop>
  macm File.Close\ Window key=<nop>
  macm File.Print key=<D-P>
  macm File.New\ Window key=<nop>
  macm Tools.List\ Errors key=<nop>
  macm File.Save key=<nop>
endif

" read per-project vimrc files
set exrc
