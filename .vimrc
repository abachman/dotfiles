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

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

" Custom Status Line
set statusline=%t%m\ cwd:\ %r%{CurDir()}%h%=col:%3v\ line:%4l\ of\ %L\ %p%%

function! CurDir()
  let curdir = substitute(getcwd(), '/home/adam/', "~/", "g")
  return curdir
endfunction

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" change buffer path to that of the current file
" autocmd BufEnter * lcd %:p:h

" highlight cursor line in INSERT mode.
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

"clean trailing spaces
noremap <silent> <leader>v mv:%s/\s\+$//g<CR>`v

"dont continue comments when pushing o/O
set formatoptions-=o

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

" grep options
set grepprg=ack
set grepformat=%f:%l:%m

" assume the /g flag on :s substitutions to replace all matches in a line
set gdefault

" keep 3 lines visible at top and bottom
set scrolloff=3

" NerdTree
let NERDTreeShowBookmarks=1
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" Tag List
map <leader>t :TlistToggle<CR>

" BufExplorer
let g:bufExplorerSortBy='number'

" Command-T (supercedes FuzzyFinderTextMate)
let g:CommandTMaxHeight=20
let g:CommandTScanDotDirectories=0
let wildignore=".git/**,.svn/**,*.log,vendor/**,public/paperclip/**,public/images/**,public/flash/**,public/gallery/**,test/tmp/**,tmp/**,tmp/system/**,public/system,public/system/**,**/javascripts/tiny_mce/**,*.png,*.jpg,*.db,*.gif,*.jpeg,*.swf"
map <C-t> :CommandT<CR>

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
"nmap <C-a> 0
"imap <C-a> <Home>
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

" Run a shell command in a new window
command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1,a:cmdline)
  call setline(2,substitute(a:cmdline,'.','=','g'))
  execute 'silent $read !'.escape(a:cmdline,'%#')
  setlocal nomodifiable
  1
endfunction
command! -complete=file -nargs=* Svn call s:RunShellCommand('svn '.<q-args>)

map <leader>q <esc>:call WrapMode()<CR>
function! WrapMode()
  setlocal formatoptions=l
  setlocal wrap
  setlocal lbr
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
  "improve autocomplete menu color
  let g:closetag_html_style=1
  " Insert comments markers
  map - :s/^/#/<CR>:nohlsearch<CR>
  " wrap selected text in ERB escape tag
  vnoremap <leader>m "zdi<%= <C-R>z %><ESC>
  set foldmethod=manual "auto fold
endfunction

" json is javascript
autocmd BufNewFile,BufReadPost,BufEnter *.json set filetype=javascript

function! s:MyPythonSettings()
  set ai sw=4 sts=4 et
  " insert comments marker
  map - :s/^/#/<CR>:nohlsearch<CR>
  set foldmethod=marker "auto fold
endfunction

" lcd to current rails project root
map <silent> <leader>r :if exists("b:rails_root")<CR>:Rlcd<CR>:endif<CR>
" lcd to current file path
map <silent> <leader>R :lcd %:p:h<CR>

" Enable closetag macro
" au Filetype markdown,html,xhtml,xml,xsl,eruby,ruby,md,txt,htm,js,javascript
source ~/.vim/macros/closetag.vim

" Run with rails root as cwd
map <leader>j :! rhino lib/fulljslint.js %:p<CR>


