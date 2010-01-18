set nocompatible          " We're running Vim, not Vi!
syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

set showmatch "show matching surround
set hidden    "allow hiding buffers without save

colorscheme desert

" don't leave backup files scattered about.
set updatecount=0
set nobackup
set nowritebackup
" set dir=~/tmp       " swap file storage directory

set nowrap            "no text wrapping
set selectmode=key    "shifted arrows for selection
set nonu              "don't show line numbers
set foldcolumn=0      "little space on the left.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set ai                "auto indent
set expandtab
set smarttab
set ww=<,>,[,],h,l    "wrap on movement keys
let mapleader = ","

" Custom Status Line
set statusline=%t%m%r%h%=%l,%v\ %p%%\ of\ %L\ %40{strftime('%c')}

" Enable closetag macro
au Filetype markdown,html,xml,xsl,eruby,ruby,md,txt source ~/.vim/macros/closetag.vim

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" change buffer path to that of the current file
autocmd BufEnter * lcd %:p:h

" highlight cursor line in INSERT mode.
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul

" grep options
set grepprg=ack
set grepformat=%f:%l:%m

" NerdTree
let NERDTreeShowBookmarks=1
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" Tag List
map <leader>t :TlistToggle<CR>

" BufExplorer
let g:bufExplorerSortBy='number'

" FuzzyFinder
"   current: http://github.com/jamis/fuzzyfinder_textmate/tree/master
"   (2009-02-09)
" FUZZYROOTS:
" /home/adam/workspace/psl/branches/community-finder
" /home/adam/workspace/psl/trunk
" /home/adam/workspace/windcurrent
" /home/adam/workspace/xom_bac_v2/rails
let g:fuzzy_roots=['/home/adam/workspace/psl/trunk']
let g:fuzzy_ignore=".git/**,.svn/**,*.log,vendor/**,public/paperclip/**,public/images/**,public/flash/**,public/gallery/**,test/tmp/**,tmp/**,tmp/system/**,public/system,public/system/**"
let g:fuzzy_ceiling=5000
let g:fuzzy_matching_limit=10
let g:fuzzy_enumerating_limit=8
" snippetsEmu
let g:snippetsEmu_key="<C-Tab>"

" Key Mappings
" reload vimrc
nmap ,s :source ~/.vimrc<CR>
nmap ,g :source ~/.gvimrc<CR>
" Tab and Shift-Tab indent and unindent
inoremap <S-Tab> <esc>mp<<2h`pa
noremap <Tab> >>
noremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
" Fuzzy Finder (like text mate)
map <C-t> :FuzzyFinderTextMate<CR>
" Buffer nav with C-n C-p
inoremap <C-h> <esc><C-w><C-h>
inoremap <C-j> <esc><C-w><C-j>
inoremap <C-k> <esc><C-w><C-k>
inoremap <C-l> <esc><C-w><C-l>
noremap <C-h> <C-w><C-h>
noremap <C-j> <C-w><C-j>
noremap <C-k> <C-w><C-k>
noremap <C-l> <C-w><C-l>
" Copy paste using system clipboard
vmap <C-y> "+y
vmap <C-u> "+p
nmap <C-u> "+p
imap <C-u> <esc>"+p
imap <C-v> <esc>pa
" Home/end like emacs and bash
nmap <C-e> $
imap <C-e> <End>
nmap <C-a> 0
imap <C-a> <Home>
" CTRL-S is Save
noremap <C-s> :w<CR>
inoremap <C-s> <esc>:w<CR>
" ,bd to close buffer without changing window layout.
nmap <leader>bd :Bclose<CR>
imap <C-b>d <esc>:Bclose<CR>
" select current definition
nmap <leader>vm <esc>[mmd]MV'd
" shift up / down moves the cursor
vmap <S-up> <up>
vmap <S-down> <down>
nmap <S-up> V<up>
nmap <S-down> V<down>
nmap <S-right> v<right>
nmap <S-left> v<left>
inoremap <S-up> <esc>v<up>
inoremap <S-down> <esc>v<down>
inoremap <S-right> <esc>v<right>
inoremap <S-left> <esc>v<left>
" unmap shift-k
vmap K <up>
nmap K <up>

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

map <leader>q <esc>:call WrapMode()<CR>
function! WrapMode()
  setlocal wrap
  setlocal lbr
  setlocal nonumber
  setlocal foldmethod=manual
  " treat long wrapped lines (paragraphs) like short lines.
  " i.e., directional keys move directly up and down visually
  " and movement keys wrap to the next visual line, not the
  " next line break.
  map <buffer> <up> gk
  imap <buffer> <up> <C-o>gk
  map <buffer> <down> gj
  imap <buffer> <down> <C-o>gj
  map <buffer> <home> g<home>
  imap <buffer> <home> <C-o>g<home>
  map <buffer> <end> g<end>
  imap <buffer> <end> <C-o>g<end>
  map <buffer> j gj
  map <buffer> k gk
endfunction


"""""" Filetype Specific Settings
augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  autocmd BufRead *.as set filetype=actionscript
  autocmd BufRead *.mxml set filetype=mxml
  autocmd BufRead *.rtex set filetype=tex
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.ru set filetype=ruby
  autocmd FileType java,c,cpp,c++ call s:MyCLikeSettings()
  autocmd FileType ruby,eruby call s:MyRubySettings()
  autocmd FileType vim call s:MyVimSettings()
  autocmd FileType python call s:MyPythonSettings()
  autocmd FileType markdown call s:MyMarkdownSettings()
augroup END

" Clear all comment markers (one rule for all languages)
map <leader>_ :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

function! s:MyCLikeSettings()
  " Insert comments markers
  map - :s/^/\/\//<CR>:nohlsearch<CR>
endfunction

function! s:MyMarkdownSettings()
  set ai formatoptions=tcroqn2 comments=n:>
endfunction

function! s:MyVimSettings()
  " Insert comments markers
  map - :s/^/\"/<CR>:nohlsearch<CR>
endfunction

function! s:MyRubySettings()
  set ai sw=2 sts=2 et
  set omnifunc=rubycomplete#Complete
  let g:rubycomplete_buffer_loading=1
  let g:rubycomplete_rails=1
  let g:rubycomplete_classes_in_global=1
  "improve autocomplete menu color
  highlight Pmenu ctermbg=238 gui=bold
  let g:closetag_html_style=1
  " Insert comments markers
  map - :s/^/#/<CR>:nohlsearch<CR>
  " select current def (in ruby)
  vnoremap <leader>m "zdi<%= <C-R>z %><ESC>
  set foldmethod=manual "auto fold
endfunction

function! s:MyPythonSettings()
  set ai sw=4 sts=4 et
  " insert comments marker
  map - :s/^/#/<CR>:nohlsearch<CR>
  set foldmethod=marker "auto fold
endfunction

" http://www.37signals.com/svn/posts/1616-introducing-the-projectsearch-rails-plugin
function! RailsScriptSearch(args)
  let l:savegrepprg = &grepprg
  let l:savegrepformat = &grepformat

  try
    let l:_buffer = bufnr('%')
    let l:_rails_root = getbufvar(_buffer, 'rails_root')
    exe 'lcd ' . l:_rails_root
    set grepprg=script/find
    set grepformat=%f:%l:%m
    execute "grep " . a:args
  finally
    execute "set grepformat=" . l:savegrepformat
    execute "set grepprg=" . l:savegrepprg
  endtry
endfunction

" search with explicitly provided arguments
command! -n=? Rgrep :call RailsScriptSearch('<args>')

" search for the word under the cursor
map <leader>rg :silent call RailsScriptSearch(expand("<cword>"))<CR>:cc<CR>

" search for the method definition of the word under the cursor
map <leader>rd :silent call RailsScriptSearch(expand("'def .*<cword>'"))<CR>:cc<CR>
