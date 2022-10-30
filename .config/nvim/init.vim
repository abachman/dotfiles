call plug#begin()

Plug 'preservim/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'mileszs/ack.vim'
Plug 'qpkorr/vim-bufkill'

call plug#end()

syntax on                                  " Enable syntax highlighting
filetype plugin indent on                  " Enable filetype-specific indenting and plugins

set showmatch "show matching surround
set hidden    "allow hiding buffers without save

colorscheme torte
highlight Normal guibg=black guifg=white
set background=dark

" don't leave backup files scattered about.
set updatecount=0
set nobackup
set nowritebackup
set backupcopy=yes

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
set mouse=a           " allow mouse to work in the terminal

let mapleader = ","

" highlight searches, clear with spacebar
set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Always show status line
set laststatus=2

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" highlight cursor line in INSERT mode.
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul

"tell the term has 256 colors
set t_Co=256

" assume the /g flag on :s substitutions to replace all matches in a line
set gdefault

" keep 3 lines visible at top and bottom
set scrolloff=3

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

" unmap shift-k
vmap K <up>
nmap K <up>

" CTRL-S is Save
noremap <C-s> :w<CR>
inoremap <C-s> <esc>:w<CR>

" leader s also saves
noremap <leader>s :w<CR>
inoremap <leader><leader>s <esc>:w<CR>

" in case of fatfinger
command! W :w

" ,bd to close buffer without changing window layout.
nmap <leader>bd :BW<CR>
imap <C-b>d <esc>:BW<CR>

" toggle numbers
nmap <leader>n :set nonu!<CR>

" hashrocket!
imap hh =>

" esc from insert mode with this uncommon keystroke
imap jj <esc>

" Use modeline overrides
set modeline
set modelines=10

" NerdTree
let NERDTreeShowBookmarks=0
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" fzf.vim
map <leader>p :Files<CR>
map <C-p> :Files<CR>

" ack (ag under the hood)
if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column -p /Users/adam/.agignore'
endif
map <leader>a :Ack<space>
vmap <leader>a "ay:Ack<space><C-r>a<CR>
" close quickfix buffer
map <leader>x :ccl<CR>
