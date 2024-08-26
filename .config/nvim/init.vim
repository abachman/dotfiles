set nocompatible
filetype plugin indent on
syntax enable

call plug#begin()
  Plug 'nvim-lua/plenary.nvim'

  Plug 'nvim-treesitter/nvim-treesitter'
  Plug 'neovim/nvim-lspconfig'
  Plug 'abachman/neoformat', { 'branch': 'add-biome-format' }

  " Plug 'github/copilot.vim'
  Plug 'sourcegraph/sg.nvim', { 'do': 'nvim -l build/init.lua' }

  Plug 'preservim/nerdtree'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'jlanzarotta/bufexplorer'
  Plug 'qpkorr/vim-bufkill'
  if has("linux")
    Plug 'windwp/nvim-projectconfig'
  endif
  Plug 'tpope/vim-fugitive'   " git
  Plug 'tpope/vim-commentary' " commenting
  Plug 'tpope/vim-surround'
  Plug 'mustache/vim-mustache-handlebars'
  Plug 'godlygeek/tabular'

  " colorschemes
  Plug 'crusoexia/vim-monokai'
  Plug 'vim-scripts/wombat256.vim'
  Plug 'abachman/vim-desert-black'
  Plug 'toupeira/vim-desertink'
  Plug 'folke/tokyonight.nvim'
  Plug 'rose-pine/neovim'
  Plug 'rebelot/kanagawa.nvim'

  " writing mode
  Plug 'reedes/vim-pencil'       " Super-powered writing things
  Plug 'junegunn/limelight.vim'  " Highlights only active paragraph
  Plug 'junegunn/goyo.vim'       " Full screen writing mode
  Plug 'reedes/vim-lexical'      " Better spellcheck mappings
  Plug 'reedes/vim-litecorrect'  " Better autocorrections
  Plug 'folke/zen-mode.nvim'
  Plug 'folke/twilight.nvim'
call plug#end()

set showmatch "show matching surround
set hidden    "allow hiding buffers without save

lua require('colorscheme')

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

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

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
inoremap <C-j> <esc><C-w>j
inoremap <C-k> <esc><C-w>k
imap <C-k> <esc><C-w><C-k>
inoremap <C-l> <esc><C-w><C-l>
noremap <C-h> <C-w><C-h>
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
nmap <C-k> <esc><C-w>k
noremap <C-l> <C-w><C-l>

" unmap shift-k
vmap K <up>
nmap K <up>

" Enable closetag macro all the time
let b:unaryTagsStack=""
let b:closetag_html_style=1
let b:closetag_disable_synID=1
" source ~/.vim/plugins/closetag.vim
" let b:unaryTagsStack=""
" let b:closetag_html_style=1
" let b:closetag_disable_synID=1

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
let g:NERDTreeIgnore = ['^node_modules$']
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>D :NERDTreeFind<CR>

" fzf.vim, ctrl-p to launch
" let $FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'
map <leader>p :Files<CR>
map <C-p> :Files<CR>

" Ag comes with fzf + apt install the_silver_searcher
map <leader>a :Ag<space>
vmap <leader>a "ay:Ag<space><C-r>a<CR>

" close quickfix buffer
map <leader>x :ccl<CR>

" vim-projectconfig
if has("linux")
  lua require('nvim-projectconfig').setup()
endif

" neoformat
let g:neoformat_try_node_exe = 1
" let g:neoformat_verbose = 1 " for debugging
map <leader>f :Neoformat<CR>

let g:neoformat_enabled_javascript = ['biome', 'denofmt']
let g:neoformat_enabled_javascriptreact = ['biome', 'denofmt']
let g:neoformat_enabled_typescript = ['biome', 'denofmt']
let g:neoformat_enabled_typescriptreact = ['biome', 'denofmt']
let g:neoformat_enabled_json = ['biome', 'denofmt']
let g:neoformat_enabled_jsonc = ['biome', 'denofmt']
let g:neoformat_enabled_ruby = ['standard']

" lsp configuration
" https://github.com/neovim/nvim-lspconfig#Suggested-configuration
lua require('init-lsp')

" sourcegraph cody setup
" https://sourcegraph.com/docs/cody/clients/install-neovim
lua require('sg').setup()

" pencil
augroup pencil
 autocmd!
 autocmd filetype markdown,mkd call pencil#init()
     \ | call lexical#init()
     \ | call litecorrect#init()
     \ | setl spell spl=en_us fdl=4 noru nonu nornu
     \ | setl fdo+=search
augroup END

" Pencil / Writing Controls
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#textwidth = 74
let g:pencil#joinspaces = 0
let g:pencil#cursorwrap = 1
let g:pencil#conceallevel = 3
let g:pencil#concealcursor = 'c'
let g:pencil#softDetectSample = 20
let g:pencil#softDetectThreshold = 130

" Python
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" zen-mode.nvim
"
" better to call lua require(...)
lua << EOF
  require("zen-mode").setup({
    window = {
      backdrop = 0.95,
      width = 100,
      height = 1,
      options = {
        list = true
      },
    },
    plugins = {
      options = {
        enabled = true,
      },

      twilight = { enabled = true },
      alacritty = {
        enabled = true,
        font = "14", -- font size
      },
    },
  })
EOF

if exists("g:neovide")
  " Put anything you want to happen only in Neovide here
  let g:neovide_cursor_animation_length = 0.01
endif

if has("mac")
  set guifont=Menlo:h15

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

  map <D-s> :w<CR>          " just save
  imap <D-s> <esc>:w<CR>    " save and return to normal mode (saves a keystroke)
  vmap <D-s> <esc>:w<CR>gv  " save and return to previous visual selection

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

" At the bottom of your init.vim, keep all configs on one line
lua require'nvim-treesitter.configs'.setup{highlight={enable=true}}

