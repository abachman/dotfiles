set nocompatible                           " We're running Vim, not Vi!

" use proper ruby
let g:ruby_path=$RUBY_BIN

" system specific
execute pathogen#infect()

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
set nofoldenable      " disable folding
set tabstop=2
set shiftwidth=2
set softtabstop=2
set ai                "auto indent
set expandtab
set smarttab
set smartcase         " ignore case in searches unless specific case is given
set wrapscan          " wrap searches
set ww=<,>,[,],h,l    "wrap on movement keys
let mapleader = ","

" highlight searches, clear with spacebar
set hlsearch
set hl=l:Visual
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Fast editing of the .vimrc
" map <leader>e :e! ~/.vimrc<cr>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

function! CurDir()
  let curdir = substitute(getcwd(), '/home/adam/', "~/", "g")
  return curdir
endfunction

" Always show status line
set laststatus=2

" objective-c and clang
" http://objvimmer.com/blog/2012/08/17/objective-c-code-completion-in-vim/
" https://github.com/Rip-Rip/clang_complete
let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'

" golang
let g:go_fmt_command = "goimports"

" Syntastic
let g:syntastic_enable_signs=0
let g:syntastic_check_on_open=0
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=4
let g:syntastic_enable_balloons=0

let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_coffeescript_checkers=['jshint']

" let g:syntastic_go_checkers = ['golint', 'gotype', 'govet']
" let g:syntastic_debug = 0
" let g:syntastic_auto_jump=0
" let g:syntastic_auto_loc_list=1
" let g:syntastic_disabled_filetypes = ['html', 'xhtml', 'sass', 'scss', 'feature']

let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['ruby', 'coffee', 'javascript', 'css', 'less'],
                           \ 'passive_filetypes': ['html', 'xhtml', 'sass', 'scss', 'erlang'] }

let g:syntastic_ruby_mri_quiet_messages = { "level": "warnings",
                                          \ "type": "style",
                                          \ "regex": '\mambiguous' }

" let g:syntastic_quiet_messages = { "level": "warnings" }


" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" highlight cursor line in INSERT mode.
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul

"clean trailing spaces, convert tabs to spaces
noremap <silent> <leader>v mv:%s/\s\+$//e<CR>:%s/\t/  /e<CR>`v

" clean trailing spaces automatically before save
autocmd BufWritePre  *  call StripTrailingWhite()

function! StripTrailingWhite()
    let l:winview = winsaveview()
    silent! %s/\s\+$//
    call winrestview(l:winview)
endfunction

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

"" Command-T (supercedes FuzzyFinderTextMate)
" let g:CommandTMaxHeight=2
" let g:CommandTScanDotDirectories=0
" map <leader>t :CommandT<CR>
" map <C-t> :CommandT<CR>
" map <leader>f :CommandTFlush<CR>

" ctrlp (supercedes Command-T)
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

map <leader>f :CtrlPClearCache<CR>
map <leader>t :CtrlP<CR>
map <C-t> :CtrlP<CR>

" fuzzy finders ignoring things
" set wildmode=list:longest,list:full
set wildignore+=*.log,*.o,*.sassc,*.png,*.jpg,*.db,*.gif,*.jpeg,*.swf,*.class,*.scssc,*.pdf,public/system/*,app/mobile/*,vendor/bundle,vendor/bundle/*,node_modules/*,public/assets/*

" 'c' - the directory of the current file.
" 'r' - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr _darcs
" 'a' - like c, but only if the current working directory outside of CtrlP is not a direct ancestor of the directory of the current file.
" 0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = ''

" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)|(node_modules|vendor|app\/mobile|public\/system|Godeps)',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25,results:25'

" Use a custom file listing command:
" let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux

" Ack search
let g:ackprg = 'ag --nogroup --nocolor --column -p /Users/adam/.agignore'
map <leader>a :Ack<space>
vmap <leader>a "ay:Ack<space><C-r>a<CR>
" close quickfix buffer
map <leader>x :ccl<CR>

if has("mac")
  " create window splits with <Command-w>{s,v}
  map <D-w>s <C-w>s
  " in case I fat finger it
  map <D-w><D-s> <C-w>s
  map <D-w>q <C-w>q
  map <D-w><D-q> <C-w>q
  map <D-w>v <C-w>v
  map <D-w><D-v> <C-w>v
  " create window splits with <Command-w>{s,v}
  imap <D-w>s <esc><C-w>s
  " in case I fat finger it
  imap <D-w><D-s> <esc><C-w>s
  imap <D-w>q <esc><C-w>q
  imap <D-w><D-q> <esc><C-w>q
  imap <D-w>v <esc><C-w>v
  imap <D-w><D-v> <esc><C-w>v
  imap <D-w> <C-w>

  imap <D-p> <C-p>
  imap <D-n> <C-n>

  " map <D-t> :CommandT<CR>
  " noremap <D-t> :CommandT<CR>
  " inoremap <D-t> :CommandT<CR>
  map <D-t> :CtrlP<CR>
  noremap <D-t> :CtrlP<CR>
  inoremap <D-t> :CtrlP<CR>


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

  map <leader>w= <C-w>=
  noremap <leader>w= <C-w>=
  noremap <D-w>= <C-w>=

  " https://github.com/mattn/emmet-vim formerly Zen-Coding
  map <D-y> <C-y>
  map <D-y>, <C-y>,
endif

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
" let g:BufClose_AltBuffer = '"#"' " make sure bufclose doesn't create blank buffers
" nmap <leader>bd :BufClose<CR>
" imap <C-b>d <esc>:BufClose<CR>
nmap <leader>bd :BW<CR>
imap <C-b>d <esc>:BW<CR>

" select current definition
nmap <leader>vm <esc>[mmd]MV'd

" shift up / down moves the selection cursor
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

" esc from insert mode with this uncommon keystroke
imap jj <esc>

" tabularize on =
vmap <leader>= :Tabularize /=<CR>

" titleize selection (linewise, crap)
" vnoremap <silent> T :s/\v^.\|<%(is>\|in>\|the>\|at>\|with>\|a>)@!./\U&/<CR>:nohlsearch<Bar>:echo<CR>

"""" System specific or plugin related """"

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

" map <leader>q <esc>:call WrapMode()<CR>
" inoremap <leader>q <esc>:call WrapMode()<CR>

noremap <silent> <Leader>w :call ToggleWrap()<CR>
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
    silent! ounmap <buffer> j
    silent! ounmap <buffer> k
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
    onoremap <buffer> <silent> j gj
    onoremap <buffer> <silent> k gk
  endif
endfunction

" function! WrapMode()
"   setlocal formatoptions=tcq
"   setlocal textwidth=80
"   setlocal wrap
"   setlocal lbr
"   "setlocal foldmethod=manual
"   "setlocal spell
"
"   " treat long wrapped lines (paragraphs) like short lines.
"   " i.e., directional keys move directly up and down visually
"   " and movement keys wrap to the next visual line, not the
"   " next line break.
"   map <buffer> <up> gk
"   imap <buffer> <up> <C-o>gk
"   map <buffer> <down> gj
"   imap <buffer> <down> <C-o>gj
"   map <buffer> <home> g<home>
"   imap <buffer> <home> <C-o>g<home>
"   map <buffer> <end> g<end>
"   imap <buffer> <end> <C-o>g<end>
"   map <buffer> j gj
"   map <buffer> k gk
" endfunction

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
  autocmd BufRead *.ejs set filetype=jst
  autocmd BufRead *.mustache set filetype=mustache
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.ru set filetype=ruby
  autocmd BufRead,BufNewFile Gemfile set filetype=ruby
  autocmd BufRead,BufNewFile Rakefile set filetype=ruby
  autocmd BufRead,BufNewFile Capfile set filetype=ruby
  autocmd BufRead,BufNewFile Guardfile set filetype=ruby
  autocmd BufRead,BufNewFile *.jbuilder set filetype=ruby
  autocmd BufRead,BufNewFile *.scss  set filetype=scss
  autocmd FileType java,c,cpp,c++ call s:MyCLikeSettings()
  autocmd FileType objc call s:MyObjcSettings()
  autocmd FileType ruby,eruby call s:MyRubySettings()
  autocmd FileType vim call s:MyVimSettings()
  autocmd FileType python call s:MyPythonSettings()
  autocmd FileType markdown call s:MyMarkdownSettings()
  autocmd FileType clojure call s:MyClojureSettings()
  autocmd FileType actionscript,mxml call s:MyFlexSettings()
  autocmd FileType go call s:MyGoSettings()
augroup END

augroup myprojectdirs
  autocmd!

  if has("mac")
    au! BufRead,BufNewFile /Users/adam/projects/store/* set wildignore+=invoicerator/*
  endif
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

function! s:MyObjcSettings()
  set ai sw=4 sts=4 et
  let c_no_curly_error = 1
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

" golang
function! s:MyGoSettings()
  " autocmd BufWritePre,FileWritePre *.go :SyntasticCheck
  " autocmd BufWritePost *.go :SyntasticCheck
  " autocmd BufWritePost,FileWritePost *.go execute 'GoBuild' | cwindow
  nnoremap <leader>gi :%! goimports %<CR>
  nnoremap <leader>gd :GoDef<CR>
  nnoremap <leader>gs :sp<CR>:GoDef<CR>
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

" Use project-local vim config
let b:thisdir=expand("%:p:h")
let b:vim=b:thisdir."/.vim"
if (filereadable(b:vim))
    execute "source ".b:vim
endif

