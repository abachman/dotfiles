set nocompatible                           " We're running Vim, not Vi!

" system specific
call pathogen#runtime_append_all_bundles() " autoload .vim/bundle

syntax on                                  " Enable syntax highlighting
filetype plugin indent on                  " Enable filetype-specific indenting and plugins

set showmatch "show matching surround
set hidden    "allow hiding buffers without save

set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="hight"
colorscheme solarized
" colorscheme desert
" colorscheme Tomorrow-Night

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

" highlight searches, clear with spacebar
set hlsearch
set hl=l:Visual
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

function! CurDir()
  let curdir = substitute(getcwd(), '/home/adam/', "~/", "g")
  return curdir
endfunction

" Always show status line
set laststatus=2
" Custom Status Line
set statusline=%t%m\ cwd:\ %{exists('g:loaded_rvm')?rvm#statusline():''}\ %r%{CurDir()}%h%=col:%3v\ line:%4l\ of\ %L\ %p%%
" rvm.vim sample
" set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%{exists('g:loaded_rvm')?rvm#statusline():''}%=%-16(\ %l,%c-%v\ %)%P

" Syntastic
let g:syntastic_enable_signs=0
let g:syntastic_auto_jump=0
let g:syntastic_auto_loc_list=1
let g:syntastic_disabled_filetypes = ['html', 'xhtml', 'sass', 'scss']

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" highlight cursor line in INSERT mode.
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul

"clean trailing spaces, convert tabs to spaces
noremap <silent> <leader>v mv:%s/\s\+$//e<CR>:%s/\t/  /e<CR>`v
" autocmd BufWritePre * :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" don't continue comments when pushing o/O
set formatoptions-=o

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

" assume the /g flag on :s substitutions to replace all matches in a line
set gdefault

" keep 3 lines visible at top and bottom
set scrolloff=3

" NerdTree
let NERDTreeShowBookmarks=0
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" BufExplorer
let g:bufExplorerSortBy='mru'

" Command-T (supercedes FuzzyFinderTextMate)
let g:CommandTMaxHeight=20
let g:CommandTScanDotDirectories=0
set wildmode=list:longest,list:full
set wildignore+=*.log,*.o,*.sassc,*.png,*.jpg,*.db,*.gif,*.jpeg,*.swf,*.class,*.scssc,*.pdf,public/system/**,app/mobile/**
map <leader>t :CommandT<CR>
map <C-t> :CommandT<CR>
map <leader>f :CommandTFlush<CR>

" Ack search
map <leader>a :Ack<space>
vmap <leader>a "ay:Ack<space><C-r>a<CR>
map <leader>x :ccl<CR>   " close quickfix buffer

" sessions
set sessionoptions-=buffers

fu! SaveSess()
  execute 'call mkdir(%:p:h/.vim)'
  execute 'mksession! %:p:h/.vim/session.vim'
endfunction

fu! RestoreSess()
  if filereadable('%:p:h/.vim/session.vim')
    execute 'so %:p:h/.vim/session.vim'

    if bufexists(1)
      for l in range(1, bufnr('$'))
        if bufwinnr(l) == -1
          exec 'sbuffer ' . l
        endif
      endfor
    endif
  endif
endfunction

autocmd VimLeave * call SaveSess()
autocmd VimEnter * call RestoreSess()

if has("mac")
  map <D-w>s <C-w>s      " create window splits with <Command-w>{s,v}
  map <D-w><D-s> <C-w>s  " in case I fat finger it
  map <D-w>q <C-w>q
  map <D-w><D-q> <C-w>q
  map <D-w>v <C-w>v
  map <D-w><D-v> <C-w>v
  imap <D-w>s <C-w>s      " create window splits with <Command-w>{s,v}
  imap <D-w><D-s> <C-w>s  " in case I fat finger it
  imap <D-w>q <C-w>q
  imap <D-w><D-q> <C-w>q
  imap <D-w>v <C-w>v
  imap <D-w><D-v> <C-w>v
  imap <D-w> <C-w>

  imap <D-p> <C-p>
  imap <D-n> <C-n>

  map <D-t> :CommandT<CR>
  noremap <D-t> :CommandT<CR>
  inoremap <D-t> :CommandT<CR>

  " paste current yank buffer
  inoremap <D-V> <esc>""pi

  map <D-s> :w<CR>        " just save
  imap <D-s> <esc>:w<CR>  " save and return to normal mode (saves a keystroke)

  " navigate splits quickly with the normal movement keys
  inoremap <D-h> <esc><C-w><C-h>
  inoremap <D-j> <esc><C-w><C-j>
  inoremap <D-k> <esc><C-w><C-k>
  inoremap <D-l> <esc><C-w><C-l>
  noremap <D-h> <C-w><C-h>
  noremap <D-j> <C-w><C-j>
  noremap <D-k> <C-w><C-k>
  noremap <D-l> <C-w><C-l>

  " esc
  inoremap <D-[> <esc>

  " format paragraph
  map <D-p> vipgq
endif

" ZenCoding: http://mattn.github.com/zencoding-vim
let g:user_zen_settings = {
      \  'indentation' : '  ',
      \  'perl' : {
      \    'aliases' : {
      \      'req' : 'require '
      \    },
      \    'snippets' : {
      \      'use' : "use strict\nuse warnings\n\n",
      \      'warn' : "warn \"|\";",
      \    }
      \  }
      \}
let g:user_zen_leader_key = '<C-z>'
let g:user_zen_expandabbr_key = '<C-e>'

" prettify
nmap <leader>p gg=G

" Key Mappings
" reload vimrc
nmap <leader>r :source ~/.vimrc<CR>
nmap <leader>g :source ~/.gvimrc<CR>

" Tab and Shift-Tab indent and unindent
inoremap <S-Tab> <esc>mp<<2h`pa
noremap <Tab> >>
noremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" window nav
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
nmap <C-a> ggVG
"nmap <C-a> 0
"imap <C-a> <Home>
" CTRL-S is Save
noremap <C-s> :w<CR>
inoremap <C-s> <esc>:w<CR>

" leader s also saves
noremap <leader>s :w<CR>
inoremap <leader><leader>s <esc>:w<CR>

" in case of fatfinger
command! W :w

" ,bd to close buffer without changing window layout.
let g:BufClose_AltBuffer = '"#"' " make sure bufclose doesn't create blank buffers
nmap <leader>bd :BufClose<CR>
imap <C-b>d <esc>:BufClose<CR>
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
" S-home in insert acts like ^ in normal
inoremap <S-home> <esc>^i
" unmap shift-k
vmap K <up>
nmap K <up>
" toggle numbers
nmap <leader>n :set nonu!<CR>

" hashrocket!
imap hh =>

" esc
imap jj <esc>

" titleize selection (linewise, crap)
" vnoremap <silent> T :s/\v^.\|<%(is>\|in>\|the>\|at>\|with>\|a>)@!./\U&/<CR>:nohlsearch<Bar>:echo<CR>

"""" System specific or plugin related """"

" NerdTree
let NERDTreeShowBookmarks=0
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" BufExplorer
let g:bufExplorerSortBy='mru'

" Command-T (supercedes FuzzyFinderTextMate)
let g:CommandTMaxHeight=20
let g:CommandTScanDotDirectories=0
set wildignore+=*.log,*.o,*.sassc,*.png,*.jpg,*.db,*.gif,*.jpeg,*.swf,*.class,*.scssc,*.pdf,public/richter_data/*.xml
set wildignore+=**/generated/**,*.cache,bin-debug/**,deploy/**,*.swc,public/system/**,var/vhosts/**
map <C-t> :CommandT<CR>
map <leader>f :CommandTFlush<CR>

" ZenCoding: http://mattn.github.com/zencoding-vim
let g:user_zen_settings = {
      \  'indentation' : '  ',
      \  'perl' : {
      \    'aliases' : {
      \      'req' : 'require '
      \    },
      \    'snippets' : {
      \      'use' : "use strict\nuse warnings\n\n",
      \      'warn' : "warn \"|\";",
      \    }
      \  }
      \}
let g:user_zen_leader_key = '<C-z>'
let g:user_zen_expandabbr_key = '<C-e>'

" Load matchit (% to bounce from do to end, etc.)
runtime! macros/matchit.vim

" gist-vim defaults
if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1

" Use modeline overrides
set modeline
set modelines=10

"For screen.vim send block
"to SendScreen function
"(eg Scheme interpreter)
"http://www.vim.org/scripts/script.php?script_id=2711
vmap <C-c><C-c> :ScreenSend<CR>
nmap <C-c><C-c> vip<C-c><C-c>

map <leader>h <esc>:call ProjectionMode()<CR>
function! ProjectionMode()
  if has("mac")
    set gfn=Inconsolata:h16
  else
    set gfn=Inconsolata\ 16
  endif
  set laststatus=0
  set showcmd
endfunction

map <leader>q <esc>:call WrapMode()<CR>
inoremap <leader>q <esc>:call WrapMode()<CR>
function! WrapMode()
  setlocal formatoptions=tcq
  setlocal textwidth=80
  setlocal wrap
  setlocal lbr
  setlocal foldmethod=manual
  "setlocal spell

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

  " lcd to current rails project root
  autocmd BufRead *.as set filetype=actionscript
  autocmd BufRead *.mxml set filetype=mxml
  autocmd BufRead *.rtex set filetype=tex
  autocmd BufRead *.clj set filetype=clojure
  autocmd BufRead *.jst set filetype=jst
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.ru set filetype=ruby
  autocmd BufRead,BufNewFile Gemfile set filetype=ruby
  autocmd BufRead,BufNewFile Rakefile set filetype=ruby
  autocmd BufRead,BufNewFile Capfile set filetype=ruby
  autocmd BufRead,BufNewFile Guardfile set filetype=ruby
  autocmd BufRead,BufNewFile *.scss  set filetype=scss
  autocmd FileType java,c,cpp,c++ call s:MyCLikeSettings()
  autocmd FileType ruby,eruby call s:MyRubySettings()
  autocmd FileType vim call s:MyVimSettings()
  autocmd FileType python call s:MyPythonSettings()
  autocmd FileType markdown call s:MyMarkdownSettings()
  autocmd FileType clojure call s:MyClojureSettings()
  autocmd FileType actionscript,mxml call s:MyFlexSettings()
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

  " Get rid of rails format.html { } blocks
  map <silent> <leader>rf :%s/[a-z]*\.[a-z]* { \([^}]*\) }/\1<CR>
endfunction

function! s:MyClojureSettings()
  " let g:clj_highlight_builtins=1      " Highlight Clojure's builtins
  " let g:clj_paren_rainbow=1           " Rainbow parentheses'!

  let g:vimclojure#HighlightBuiltins=1   " Highlight Clojure's builtins
  let g:vimclojure#ParenRainbow=1        " Rainbow parentheses'!
  let g:vimclojure#DynamicHighlighting=1 " Dynamically highlight functions
endfunction

function! s:MyFlexSettings()
  set smartindent sw=2 sts=2 et
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

" Enable closetag macro all the time
let b:unaryTagsStack=""
let b:closetag_html_style=1
let b:closetag_disable_synID=1
source ~/.vim/macros/closetag.vim

" Usage:
"
"   :Me ~/path/to/my/new/file.txt
"
" creates /home/username/path/to/my/new with `mkdir -p` if it doesn't exist
" and then opens file.txt
"

function! Mkdire(path)
  let l:newpath = fnamemodify(expand(a:path), ":p:h")
  let l:newfile = expand(a:path)
  if !isdirectory(l:newpath)
    call mkdir(l:newpath, "p")
  endif
  execute "e " . l:newfile
endfunction
command! -nargs=1 -complete=file Me call Mkdire(<f-args>)

" you can also automatically call the function before save (on every write)
" au BufWritePre,FileWritePre * call Mkdire('%')

